import 'dart:convert';
import 'package:app_front/storage/auth_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/service/hashing_service.dart';
import 'package:app_front/providers/auth_providers.dart';


class RegistrationStateNotifier extends StateNotifier<bool> {
  RegistrationStateNotifier(this.ref) : super(false);

  final Ref ref;
  static const String authApiMethod = "/register_user";

  Future<String> registerWithGoogle(String login) async {
    try {
      final hashedToken = await TokenHasher.getHash();
      final googleSignIn = ref.read(googleSignInProvider);
      var googleSignInAccount = await googleSignIn.signIn();
      final apiUrl = dotenv.env['API_URL'] ?? '';
      final apiPort = dotenv.env['API_PORT'] ?? '';

      if (googleSignInAccount != null) {
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'X-Requested-With': hashedToken,
          'Authorization': 'test_connection' // only after authorization
        };
        var response = await http.post(
          Uri.parse("$apiUrl:$apiPort$authApiMethod"),
          headers: requestHeaders,
          body: jsonEncode({
            "google_sign_in_account": {
              'login': login,
              'server_auth_code': googleSignInAccount.serverAuthCode,
            },
          }),
        );
        final SharedPreferences =
            await ref.read(AuthStorage.sharedPrefProvider);
        print("Response (register):/n");
        print(response.body);
        if (response.statusCode == 200) {
          // Save user data to SharedPreferences
          await SharedPreferences.setString(
              AuthStorage.AUTH_STATUS_KEY, AuthStorage.AUTHENTICATED_STATUS);
          await SharedPreferences.setString(
              AuthStorage.AUTHENTICATED_USER_EMAIL_KEY,
              googleSignInAccount.email);
        } else {
          print('Failed to send user data: ${response.statusCode}');
        }
        return SharedPreferences.getString(AuthStorage.AUTH_STATUS_KEY) ?? AuthStorage.NOT_AUTHENTICATED_STATUS;
      } else {
        print('Google sign-in failed or was cancelled.');
      }
    } catch (error) {
      print("Error: $error");
    }
    return AuthStorage.NOT_AUTHENTICATED_STATUS;
  }
}