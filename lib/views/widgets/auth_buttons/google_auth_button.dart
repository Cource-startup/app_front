import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleAuthButton({
    super.key,
  });

  Future<GoogleSignInAccount?> _handleSignIn(BuildContext context) async {
    try {
      // Google Sign In configuration object.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print(googleUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
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
