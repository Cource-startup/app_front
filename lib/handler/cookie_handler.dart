import 'package:http/http.dart' as http;

class CookieHandler {
  String _cookies = '';

  void saveCookies(http.Response response) {
    final rawCookies = response.headers['set-cookie'];
    if (rawCookies != null) {
      _cookies = rawCookies.split(RegExp(r',(?=\s*\w+=)')).map((cookie) {
        final parts = cookie.split(';');
        return parts[0].trim();
      }).join('; ');
    }
  }

  String get cookies => _cookies;

  void clearCookies() {
    _cookies = '';
  }
}
