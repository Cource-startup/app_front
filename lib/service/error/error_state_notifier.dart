import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Error state model
class ErrorState {
  final String message;

  ErrorState(this.message);
}

/// StateNotifier to manage error state
class ErrorStateNotifier extends StateNotifier<ErrorState?> {
  ErrorStateNotifier() : super(null);

  /// Show an error
  void showError(String message) {
    state = ErrorState(message);
  }

  /// Clear the error
  void clearError() {
    state = null;
  }
}

/// Global provider for the error state
final errorStateProvider =
    StateNotifierProvider<ErrorStateNotifier, ErrorState?>(
  (ref) => ErrorStateNotifier(),
);
