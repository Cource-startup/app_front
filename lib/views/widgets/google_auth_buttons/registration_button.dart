import 'dart:convert';
import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/styles/app_colors.dart';
import 'package:app_front/views/screens/main_screen.dart';
import 'package:app_front/views/widgets/google_auth_buttons/google_base_button.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegistrationButton extends GoogleBaseButton {
  final TextEditingController loginTextfieldController;

  RegistrationButton({
    super.key,
    required this.loginTextfieldController,
  });

  void _auth(BuildContext context, WidgetRef ref) async {
    final login = loginTextfieldController.text.trim();

    if (login.length < 3) {
      showErrorDialog(context, "Too short!\nLogin has to be 3 or more chars!");
      return;
    }

    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        // Call UserNotifier to handle registration
        final notifier = ref.read(userProvider.notifier);
        await notifier.registerUser(
          login: login,
          serviceAuthIdFieldName: 'google_id',
          serviceAuthCode: googleSignInAccount.serverAuthCode,
        );

        // Navigate to MainScreen after successful registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } catch (error) {
        // Handle errors from UserNotifier
        showErrorDialog(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenButton(
      'Create User',
      () => _auth(context, ref),
      color: AppColors.firstBrand,
      textColor: AppColors.white,
    );
  }
}
