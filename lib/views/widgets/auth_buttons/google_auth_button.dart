import 'package:app_front/storage/auth_storage.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:app_front/views/screens/registration_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/providers/auth_providers.dart';

class GoogleAuthButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authStateProvider.notifier);

    return ScreenButton(
      'Continue with Google',
      () {
        authStateNotifier.signInWithGoogle(context).then((authStatus) {
          if (authStatus == AuthStorage.AUTHENTICATED_STATUS) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            print('Sign-in was successful.');
          } else if (authStatus == AuthStorage.NOT_REGISTERED_STATUS) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );     
            print('Needs registration');
          } else {
            print('Sign-in was not successful.');
          }
        }).catchError((e) => print(e));
      },
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
