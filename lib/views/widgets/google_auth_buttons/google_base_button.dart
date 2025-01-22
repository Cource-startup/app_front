import 'dart:io';
import 'package:app_front/setting/config.dart';
import 'package:app_front/views/widgets/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleBaseButton extends ConsumerWidget {
  GoogleBaseButton({
    super.key,
  });

  final googleSignIn = GoogleSignIn(
    forceCodeForRefreshToken: Config.forceCodeForRefreshTokenGoogle,
    serverClientId: Platform.isAndroid ? Config.googleServerClientId : null,
  );

  void showErrorDialog(BuildContext context, String message) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // implement build in children
    throw UnimplementedError();
  }
}
