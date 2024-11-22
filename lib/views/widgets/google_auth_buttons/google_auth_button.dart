import 'dart:convert';

import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/google_auth_buttons/google_base_button.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleAuthButton extends GoogleBaseButton {
  GoogleAuthButton({
    super.key,
  });

  void auth(context, ref) async {
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      var response = await apiRequestService.post(
        '/user_auth',
        {
          'service_auth_id_field_name': 'google_id',
          'service_auth_code': googleSignInAccount.serverAuthCode,
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
      } else if (response?.statusCode == 401 &&
          json.decode(response!.body)['status'] == 'not_registered') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      } else {
        // showErrorDialog(context, "Authentication response error!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenButton(
      'Continue with Google',
      () => auth(context, ref),
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
