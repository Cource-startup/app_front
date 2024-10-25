import 'package:app_front/models/auth/auth_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const AUTHENTICATED_USER_EMAIL_KEY = 'USER_EMAIL_KEY';
  static const AUTH_STATUS_KEY = 'AUTH_KEY';
  static const NOT_REGISTERED_STATUS = 'NOT_REGISTERED';
  static const AUTHENTICATED_STATUS = 'AUTHENTICATED';
  static const NOT_AUTHENTICATED_STATUS = 'NOT_AUTHENTICATED';

  static final sharedPrefProvider = Provider((_) async {
    return await SharedPreferences.getInstance();
  });

  static final setAuthStateProvider = StateProvider<AuthResponse?>(
    (ref) => null,
  );

  static final setAuthStatusProvider = StateProvider.family<void, String>(
    (ref, authStatus) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      prefs.setString(AUTH_STATUS_KEY, authStatus);
    },
  );

  static final setAuthenticatedUserProvider =
      StateProvider.family<void, String>(
    (ref, email) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      prefs.setString(
        AUTHENTICATED_USER_EMAIL_KEY,
        email,
      );
    },
  );

  static final getAuthStatusProvider = FutureProvider<String>(
    (ref) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      return prefs.getString(AUTH_STATUS_KEY) ?? '';
    },
  );

  static final getAuthenticatedUserProvider = FutureProvider<String>(
    (ref) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      return prefs.getString(AUTHENTICATED_USER_EMAIL_KEY) ?? '';
    },
  );
  // Todo: Handle logout or and reset
  static final resetStorage = StateProvider<dynamic>(
    (ref) async {
      final prefs = await ref.watch(sharedPrefProvider);
      final isCleared = await prefs.clear();
      return isCleared;
    },
  );
}
