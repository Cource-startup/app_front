import 'package:app_front/storage/auth_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getIsAuthenticatedProvider = FutureProvider<bool>(
  (ref) async {
    final prefs = await ref.watch(AuthStorage.sharedPrefProvider);
    ref.watch(AuthStorage.setAuthStateProvider);
    return prefs.getBool(AuthStorage.IS_AUTHENTICATED_KEY) ?? false;
  },
);

final getAuthenticatedUserProvider = FutureProvider<String>(
  (ref) async {
    final prefs = await ref.watch(AuthStorage.sharedPrefProvider);
    ref.watch(AuthStorage.setAuthStateProvider);
    return prefs.getString(AuthStorage.AUTHENTICATED_USER_EMAIL_KEY) ?? '';
  },
);
// Todo: Handle logout or and reset
final resetStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(AuthStorage.sharedPrefProvider);
    final isCleared = await prefs.clear();
    return isCleared;
  },
);
