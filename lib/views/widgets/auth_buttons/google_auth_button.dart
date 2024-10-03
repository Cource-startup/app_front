import 'dart:convert';
import 'package:app_front/storage/auth_storage.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/service/hashing_service.dart';
import 'package:app_front/providers/auth_providers.dart';

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier(this.ref) : super(false);

  final Ref ref;
  static const String authApiMethod = "/user_auth";

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final hashedToken = await TokenHasher.getHash();
      final googleSignIn = ref.read(googleSignInProvider);
      final googleUser = await googleSignIn.signIn();
      final apiUrl = dotenv.env['API_URL'] ?? '';
      final apiPort = dotenv.env['API_PORT'] ?? '';

      if (googleUser != null) {
        final userData = {
          'displayName': googleUser.displayName,
          'email': googleUser.email,
          'id': googleUser.id,
          'photoUrl': googleUser.photoUrl,
          'serverAuthCode': googleUser.serverAuthCode,
        };
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'X-Requested-With': hashedToken,
          'Authorization': 'test_connection' // only after authorization
        };
        print("Request:/n");
        print("$apiUrl:$apiPort$authApiMethod");
        print(jsonEncode(userData));
        final response = await http.post(
          Uri.parse("$apiUrl:$apiPort$authApiMethod"),
          headers: requestHeaders,
          body: jsonEncode(userData),
        );
        print("Response:/n");
        print(response.body);
        if (response.statusCode == 200) {
          // Save user data to SharedPreferences
          final SharedPreferences =
              await ref.read(AuthStorage.sharedPrefProvider);
          await SharedPreferences.setBool(
              AuthStorage.IS_AUTHENTICATED_KEY, true);
          await SharedPreferences.setString(
              AuthStorage.AUTHENTICATED_USER_EMAIL_KEY, googleUser.email);

          state = true;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
        } else {
          print('Failed to send user data: ${response.statusCode}');
        }
      } else {
        print('Google sign-in failed or was cancelled.');
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}

class GoogleAuthButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authStateProvider.notifier);

    return ScreenButton(
      'Continue with Google',
      () {
        authStateNotifier.signInWithGoogle(context).then((_) {
          if (ref.watch(authStateProvider)) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            print('Sign-in was successful.');
          } else {
            print('Sign-in was not successful.');
          }
        }).catchError((e) => print(e));
      },
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
