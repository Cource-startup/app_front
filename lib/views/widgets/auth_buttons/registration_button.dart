import 'package:app_front/storage/auth_storage.dart';
import 'package:app_front/styles/app_colors.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/providers/auth_providers.dart';

class RegistrationButton extends ConsumerWidget {
  final String login;
  const RegistrationButton({
    required this.login,
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationStateNotifier =
        ref.watch(registrationStateProvider.notifier);
    return ScreenButton(
      'Create User',
      () {
        registrationStateNotifier.registerWithGoogle(login).then((authStatus) {
          if (authStatus == AuthStorage.AUTHENTICATED_STATUS) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            print('Creating was successful.');
          } else {
            print('Creating was not successful.');
            return AlertDialog(
              title: const Text("Error!"),
              content: const Text("Create couldn't create the account"),
              actions: [
                TextButton(
                  child: const Text("ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        }).catchError((e) => print(e));
      },
      color: AppColors.firstBrand,
      textColor: AppColors.white,
    );
  }
}
