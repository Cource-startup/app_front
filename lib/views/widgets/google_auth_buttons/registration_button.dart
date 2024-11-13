import 'dart:convert';
import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/styles/app_colors.dart';
import 'package:app_front/views/screens/home_screen.dart';
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

  void auth(BuildContext context, WidgetRef ref) async {
    final login = loginTextfieldController.text.trim();
    if (login.length < 3) {
      showErrorDialog(context, "Too short!\nLogin has to be 3 or more chars!");
      return;
    }
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      var response = await apiRequestService.post(
        '/register_user',
        {
          "google_sign_in_account": {
            'id': googleSignInAccount.id,
            'login': loginTextfieldController.text,
            'server_auth_code': googleSignInAccount.serverAuthCode,
          },
        },
        onError: (error) =>
            showErrorDialog(context, "Authentication request error!"),
      );
      if (response?.statusCode == 200) {
        final user = ref.read(userProvider.notifier);
        user.updateGoogleSignInAccount(googleSignInAccount);
        user.updateLogin(json.decode(response!.body)['user']['login']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        showErrorDialog(context, "Authentication response error!");
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenButton(
      'Create User',
      () => auth(context, ref),
      color: AppColors.firstBrand,
      textColor: AppColors.white,
    );
  }
}
