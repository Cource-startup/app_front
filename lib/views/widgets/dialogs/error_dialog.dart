import 'package:app_front/constant/app_strings.dart';
import 'package:app_front/service/error/error_state.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.genericErrorTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.okButton),
        ),
      ],
    );
  }
}

void showCustomError(BuildContext context, ErrorState errorState) {
  switch (errorState.type) {
    case ErrorType.userNotification:
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(message: errorState.message),
      );
      break;
    case ErrorType.networkError:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorState.message)),
      );
      break;
    case ErrorType.validationError:
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(message: errorState.message),
      );
      break;
  }
}
