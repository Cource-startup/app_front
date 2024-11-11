import 'package:app_front/model/user.dart';
import 'package:app_front/service/user/user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
