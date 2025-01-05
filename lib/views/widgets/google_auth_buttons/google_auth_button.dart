import 'dart:convert';

import 'package:app_front/handler/api_request_handler.dart';
import 'package:app_front/service/auth/auth_loading_provider.dart';
import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/views/screens/main_screen.dart';
import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/google_auth_buttons/google_base_button.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleAuthButton extends GoogleBaseButton {
  GoogleAuthButton({
    super.key,
  });

  void auth(BuildContext context, WidgetRef ref) async {
    final isLoading = ref.read(authLoadingProvider);
    if (isLoading) return; // Prevent multiple requests

    ref.read(authLoadingProvider.notifier).setLoading(true);

    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      final googleSignInAccount = await googleSignIn.signIn();
      final apiRequestService = ApiRequestHandler(ref);
      var response = await apiRequestService.post(
        '/user_auth',
        {
          'service_auth_id_field_name': 'google_id',
          'service_auth_code': googleSignInAccount!.serverAuthCode,
        },
        onError: (error) {
          showErrorDialog(context, error);
        },
      );

      if (response?.statusCode == 200) {
        final user = ref.read(userProvider.notifier);
        user.updateLogin(json.decode(response!.body)['user']['login']);
        user.updateId(json.decode(response!.body)['user']['id']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else if (response?.statusCode == 401 &&
          json.decode(response!.body)['error']['type'] ==
              'user_not_registered') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      }
    } finally {
      // Ensure loading state is reset
      ref.read(authLoadingProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);
    return ScreenButton(
      'Continue with Google',
      isLoading ? null : () => auth(context, ref),
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
