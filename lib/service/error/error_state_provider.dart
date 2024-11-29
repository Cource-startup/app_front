import 'package:app_front/service/error/error_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorStateProvider =
    StateNotifierProvider<ErrorStateNotifier, ErrorState?>((ref) {
  return ErrorStateNotifier();
});
