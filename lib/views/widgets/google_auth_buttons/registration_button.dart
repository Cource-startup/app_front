import 'dart:convert';
import 'package:app_front/handler/api_request_handler.dart';
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

  void auth(BuildContext context, WidgetRef ref) async {
    final login = loginTextfieldController.text.trim();
    if (login.length < 3) {
      showErrorDialog(context, "Too short!\nLogin has to be 3 or more chars!");
      return;
    }
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final apiRequestService = ApiRequestHandler(ref);
      var response = await apiRequestService.post(
        '/register_user',
        {
          'service_auth_id_field_name': 'google_id',
          'service_auth_code': googleSignInAccount.serverAuthCode,
          'login': loginTextfieldController.text,
        },
        onError: (error) {
          showErrorDialog(context, error);
        },
      );
      if (response?.statusCode == 200) {
        final user = ref.read(userProvider.notifier);
        user.updateLogin(json.decode(response!.body)['user']['login']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
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
