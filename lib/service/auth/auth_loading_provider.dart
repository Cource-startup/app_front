import 'package:app_front/service/auth/auth_loading_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authLoadingProvider = StateNotifierProvider<AuthLoadingNotifier, bool>(
  (ref) => AuthLoadingNotifier(),
);