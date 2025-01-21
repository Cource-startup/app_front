import 'dart:convert';
import 'dart:io';

import 'package:app_front/core/debug_printer.dart';
import 'package:app_front/handler/api_request_handler.dart';
import 'package:app_front/handler/cookie_handler.dart';
import 'package:app_front/service/main_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_front/model/user.dart';
import 'package:path_provider/path_provider.dart';


enum AuthResult { authenticated, userNotRegistered }

final cookieHandler = CookieHandler();

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  final apiRequestHandler = ApiRequestHandler(cookieHandler);
  return UserNotifier(apiRequestHandler);
});


class UserNotifier extends MainNotifier<User> {
  UserNotifier(ApiRequestHandler apiRequestHandler)
      : super(
          User(
            id: 0,
            login: '',
            avatar: '',
            userName: '',
            cookies: '',
          ),
          apiRequestHandler,
        );

  /// Override updateField to use User-specific copyWith
  @override
  void updateField(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'id':
        state = state.copyWith(id: value as int);
        break;
      case 'login':
        state = state.copyWith(login: value as String);
        break;
      case 'avatar':
        state = state.copyWith(avatar: value as String);
        break;
      case 'userName':
        state = state.copyWith(userName: value as String);
        break;
      case 'cookies':
        state = state.copyWith(cookies: value as String);
        break;
      default:
        throw UnsupportedError("Field $fieldName is not supported.");
    }
  }

  /// Update multiple fields dynamically and send to API
  Future<void> updateFields(Map<String, dynamic> updatedFields) async {
    // Update the local state first
    state = state.copyWith(
      id: updatedFields['id'] ?? state.id,
      login: updatedFields['login'] ?? state.login,
      avatar: updatedFields['avatar'] ?? state.avatar,
      userName: updatedFields['user_name'] ?? state.userName,
      cookies: updatedFields['cookies'] ?? state.cookies,
    );

    // Send the updated fields to the API
    try {
      final response = await apiRequestHandler.post(
        '/update_user/${state.id}',
        updatedFields,
      );

      if (response?.statusCode != 200) {
        throw Exception('Failed to update user on API');
      }
    } catch (e) {
      print('Error updating user: $e');
      // Optionally, revert local changes if the API request fails
    }
  }

  Future<void> registerUser({
    required String login,
    required String serviceAuthIdFieldName,
    required String? serviceAuthCode,
  }) async {
    final response = await apiRequestHandler.post(
      '/register_user',
      {
        'service_auth_id_field_name': serviceAuthIdFieldName,
        'service_auth_code': serviceAuthCode,
        'login': login,
      },
    );

    if (response?.statusCode == 200) {
      final userData = json.decode(response!.body)['user'];
      updateFields(userData);
    } else {
      throw Exception('Failed to register user.');
    }
  }

  Future<AuthResult> authenticateUser({
    required String serviceAuthIdFieldName,
    required String serviceAuthCode,
  }) async {
    final response = await apiRequestHandler.post(
      '/user_auth',
      {
        'service_auth_id_field_name': serviceAuthIdFieldName,
        'service_auth_code': serviceAuthCode,
      },
    );

    if (response != null) {
      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        updateFields(body['user']);
        return AuthResult.authenticated;
      } else if (response.statusCode == 401 &&
          body['error']['type'] == 'user_not_registered') {
        return AuthResult.userNotRegistered;
      }
    }

    throw Exception('Authentication failed.');
  }


  /// Uploads a new avatar to the API and returns the avatar URL
  Future<String> uploadAvatar(File avatarFile) async {
    try {
      final response = await apiRequestHandler.uploadFile(
        '/upload_avatar/${state.id}',
        avatarFile,
        fieldName: 'avatar',
      );
      
      DebugPrinter.log(json.encode(response), tag: "API_RESPONSE");
      if (response?.statusCode == 200) {
        final responseData = json.decode(response!.body);
        return responseData['avatar_url']; // Get the avatar URL from API response
      } else {
        throw Exception('Failed to upload avatar.');
      }
    } catch (e) {
      print('Error uploading avatar: $e');
      throw e;
    }
  }

  /// Downloads and saves the avatar file locally, returning the local file path
  Future<String> saveAvatarLocally(String avatarUrl, String fileName) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final avatarPath = '${appDir.path}/$fileName';

      final response = await apiRequestHandler.downloadFile(avatarUrl);

      if (response != null && response.statusCode == 200) {
        final file = File(avatarPath);
        await file.writeAsBytes(response.bodyBytes);
        return avatarPath;
      } else {
        throw Exception('Failed to download avatar.');
      }
    } catch (e) {
      print('Error saving avatar locally: $e');
      throw e;
    }
  }

  /// Deletes the old avatar file from local storage
  Future<void> deleteOldAvatar(String oldFilePath) async {
    final oldFile = File(oldFilePath);
    if (await oldFile.exists()) {
      await oldFile.delete();
    }
  }

  /// Ensures the avatar exists locally and downloads it if necessary
  Future<void> initializeAvatar(String apiAvatarUrl) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = apiAvatarUrl.split('/').last;
      final localPath = '${appDir.path}/$fileName';

      if (!File(localPath).existsSync()) {
        final downloadedPath = await saveAvatarLocally(apiAvatarUrl, fileName);
        state = state.copyWith(avatar: downloadedPath); // Update state with local path
      } else {
        state = state.copyWith(avatar: localPath); // Use existing local file
      }
    } catch (e) {
      print('Error initializing avatar: $e');
      throw e;
    }
  }

  /// Updates the avatar and handles local storage
  Future<void> updateAvatar(File newAvatarFile) async {
    final oldAvatarPath = state.avatar;

    // Step 1: Upload the new avatar
    final avatarUrl = await uploadAvatar(newAvatarFile);

    // Step 2: Save the new avatar locally
    final fileName = avatarUrl.split('/').last;
    final localAvatarPath = await saveAvatarLocally(avatarUrl, fileName);

    // Step 3: Update state
    state = state.copyWith(avatar: localAvatarPath);

    // Step 4: Delete the old avatar file
    if (oldAvatarPath.isNotEmpty && oldAvatarPath != localAvatarPath) {
      await deleteOldAvatar(oldAvatarPath);
    }
  }
}
