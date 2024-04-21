import 'package:app_front/models/auth/auth_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const IS_AUTHENTICATED_KEY = 'IS_AUTHENTICATED_KEY';
  static const AUTHENTICATED_USER_EMAIL_KEY = 'AUTHENTICATED_USER_EMAIL_KEY';

  static final sharedPrefProvider = Provider((_) async {
    return await SharedPreferences.getInstance();
  });

  static final setAuthStateProvider = StateProvider<AuthResponse?>(
    (ref) => null,
  );

  static final setIsAuthenticatedProvider = StateProvider.family<void, bool>(
    (ref, isAuth) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      prefs.setBool(
        IS_AUTHENTICATED_KEY,
        isAuth,
      );
    },
  );

  static final setAuthenticatedUserProvider = StateProvider.family<void, String>(
    (ref, email) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      prefs.setString(
        AUTHENTICATED_USER_EMAIL_KEY,
        email,
      );
    },
  );

  static final getIsAuthenticatedProvider = FutureProvider<bool>(
    (ref) async {
      final prefs = await ref.watch(sharedPrefProvider);
      ref.watch(setAuthStateProvider);
      return prefs.getBool(IS_AUTHENTICATED_KEY) ?? false;
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