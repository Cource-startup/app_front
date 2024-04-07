import 'package:app_front/styles/styles.dart';
import 'package:app_front/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginScreen({super.key});

  Future<GoogleSignInAccount?> _handleSignIn() async {
    try {
      // Google Sign In configuration object.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print(googleUser);
      return googleUser;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: SvgPicture.asset(
                        'assets/images/logo__full_color_white_eyes.svg'),
                  ),
                  Text(
                    'The best courses from the best professionals',
                    style: AppFonts.strong,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
              child: AuthButton(
                  iconPath: 'assets/images/auth/google.svg',
                  text: 'Continue with Google',
                  onPressed: () {
                    _handleSignIn().then((GoogleSignInAccount? user) {
                      print(user!.displayName);
                    }).catchError((e) => print(e));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
