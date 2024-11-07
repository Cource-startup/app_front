import 'package:app_front/styles/styles.dart';
import 'package:app_front/views/widgets/auth_buttons/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text('Welcome!', style: AppFonts.h2),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
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
              child: GoogleAuthButton(),
            ),
          ],
        ),
      ),
    );
  }
}
