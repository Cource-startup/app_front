import 'dart:convert';

import 'package:app_front/handler/api_request_handler.dart';
import 'package:app_front/handler/cookie_handler.dart';
import 'package:app_front/service/main_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_front/model/user.dart';

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
      userName: updatedFields['userName'] ?? state.userName,
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
}
