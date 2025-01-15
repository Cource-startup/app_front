import 'package:hooks_riverpod/hooks_riverpod.dart';


final authLoadingProvider = StateNotifierProvider<AuthLoadingNotifier, bool>(
  (ref) => AuthLoadingNotifier(),
);

class AuthLoadingNotifier extends StateNotifier<bool> {
  AuthLoadingNotifier() : super(false); // Initial state is `false`

  /// Update the loading state
  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

