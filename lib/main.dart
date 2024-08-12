import 'dart:convert';
import 'package:app_front/storage/auth_storage.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/service/hashing_service.dart';
import 'package:app_front/providers/auth_providers.dart';

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier(this.ref) : super(false);

  final Ref ref;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final hashedPassword = await PasswordHasher.hashPassword();
      print("Hashed Password: $hashedPassword ");
      final googleSignIn = ref.read(googleSignInProvider);
      final googleUser = await googleSignIn.signIn();
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
          'X-Requested-With': hashedPassword,
          'Authorization': 'test_connection' // only after authorization
        };

        final response = await http.post(
          Uri.parse("http://10.0.2.2:8888/checking"),
          headers: requestHeaders,
          body: jsonEncode(userData),
        );

        if (response.statusCode == 200) {
          // Save user data to SharedPreferences
          final SharedPreferences =
              await ref.read(AuthStorage.sharedPrefProvider);
          await SharedPreferences.setBool(
              AuthStorage.IS_AUTHENTICATED_KEY, true);
          await SharedPreferences.setString(
              AuthStorage.AUTHENTICATED_USER_EMAIL_KEY, googleUser.email);

          state = true;

          // Check if user is registered
          final isAuthenticated = await SharedPreferences.getBool(
                  AuthStorage.IS_AUTHENTICATED_KEY) ??
              false;

          if (isAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          }
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
