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

  Future<void> _auth(BuildContext context, WidgetRef ref) async {
    final isLoading = ref.read(authLoadingProvider);
    if (isLoading) return; // Prevent multiple requests

    ref.read(authLoadingProvider.notifier).setLoading(true);

    try {
      // Sign out if already signed in
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Initiate Google Sign-In
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw Exception('Google Sign-In was cancelled.');
      }

      // Call the UserNotifier to handle authentication
      final notifier = ref.read(userProvider.notifier);
      final result = await notifier.authenticateUser(
        serviceAuthIdFieldName: 'google_id',
        serviceAuthCode: googleSignInAccount.serverAuthCode!,
      );

      // Navigate based on authentication result
    if (result == AuthResult.authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else if (result == AuthResult.userNotRegistered) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    }
    } catch (e) {
      showErrorDialog(context, e.toString());
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
      isLoading ? null : () => _auth(context, ref),
      iconPath: 'assets/images/auth/google.svg',
    );
  }
}
