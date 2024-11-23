import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthLoadingNotifier extends StateNotifier<bool> {
  AuthLoadingNotifier() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
