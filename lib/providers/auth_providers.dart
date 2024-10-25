import 'dart:io' show Platform;
import 'package:app_front/service/auth_state_notifier.dart';
import 'package:app_front/storage/auth_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_front/service/registration_notifier.dart';

final getAuthStatusProvider = FutureProvider<String>(
  (ref) async {
    final prefs = await ref.watch(AuthStorage.sharedPrefProvider);
    ref.watch(AuthStorage.setAuthStateProvider);
    return prefs.getString(AuthStorage.AUTH_STATUS_KEY) ??
        AuthStorage.NOT_AUTHENTICATED_STATUS;
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

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    serverClientId:
        Platform.isAndroid ? dotenv.env['GOOGLE_AUTH_API_CLIENT_ID'] : null,
  );
});

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref);
});


final registrationStateProvider = StateNotifierProvider<RegistrationStateNotifier, bool>((ref) {
  return RegistrationStateNotifier(ref);
});
