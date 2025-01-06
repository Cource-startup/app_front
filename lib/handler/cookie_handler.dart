import 'package:app_front/service/user/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CookieHandler {
  final WidgetRef ref;

  CookieHandler(this.ref);

  // Save cookies into the User provider
  void saveCookies(http.Response response) {
    final rawCookies = response.headers['set-cookie'];
    if (rawCookies != null) {
      final cookies = rawCookies.split(RegExp(r',(?=\s*\w+=)')).map((cookie) {
        final parts = cookie.split(';');
        return parts[0].trim(); // Take only the key-value part
      }).join('; ');

      // Store cookies in the User provider
      ref.read(userProvider.notifier).updateCookies(cookies);
    }
  }

  // Retrieve cookies from the User provider
  String get cookies {
    final user = ref.read(userProvider);
    return user?.cookies ?? '';
  }

  // Clear cookies in the User provider
  void clearCookies() {
    ref.read(userProvider.notifier).clearCookies();
  }
}
