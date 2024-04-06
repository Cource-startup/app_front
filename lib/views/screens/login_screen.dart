import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginScreen({super.key});

  Future<GoogleSignInAccount?> _handleSignIn() async {
    try {
      // Create Google Sign In configuration object.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      return googleUser;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
                'assets/images/logo__full_color_white_eyes.svg'), // Your logo here
            SizedBox(height: 50.0),
            ElevatedButton(
              child: Text('Sign in with Google'),
              onPressed: () {
                _handleSignIn().then((GoogleSignInAccount? user) {
                  print(user!.displayName);
                }).catchError((e) => print(e));
              },
            ),
          ],
        ),
      ),
    );
  }
}
