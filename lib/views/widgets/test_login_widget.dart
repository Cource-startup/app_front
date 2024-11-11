import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestLoginWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Text(
      "Hi, ${user.login}!",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: AppColors.firstBrand, // Text color
      ),
    );
  }
}
