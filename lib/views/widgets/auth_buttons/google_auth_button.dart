import 'dart:convert';

import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class GoogleAuthButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        Platform.isAndroid ? dotenv.env['GOOGLE_AUTH_API_CLIENT_ID'] : null,
  );

  GoogleAuthButton({
    super.key,
  });

  Future<GoogleSignInAccount?> _handleSignIn(BuildContext context) async {
    try {
      String url = 'http://localhost:8888/checking';
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Map<String, dynamic> userData = {
          'displayName': googleUser.displayName,
          'email': googleUser.email,
          'id': googleUser.id,
          'photoUrl': googleUser.photoUrl,
          'serverAuthCode': googleUser.serverAuthCode,
        };

        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userData),
        );
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
        } else {
          print('Failed to send user data: ${response.statusCode}');
        }
      }
      return googleUser;
    } catch (error) {
      print("Error:  ");
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenButton(
      'Continue with Google',
      () {
        _handleSignIn(context).then((GoogleSignInAccount? user) {
          print(user!.displayName);
        }).catchError((e) => print(e));
      },
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
