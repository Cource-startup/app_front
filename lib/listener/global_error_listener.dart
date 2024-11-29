import 'package:app_front/main.dart';
import 'package:app_front/service/error/error_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlobalErrorListener extends ConsumerWidget {
  final Widget child;

  const GlobalErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorState = ref.watch(errorStateProvider);

    if (errorState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorState.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  ref.read(errorStateProvider.notifier).clearError();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
    return child;
  }
}
