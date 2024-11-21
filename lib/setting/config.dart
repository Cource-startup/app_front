import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  // Hardcoded constant
  static const bool isDebugMode = true;

  // AUTH
  // Google
  static const bool forceCodeForRefreshTokenGoogle = true;
  static String get googleServerClientId =>
      dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? "";

  // API
  static String get apiUrl => dotenv.env['API_URL'] ?? 'https://localhost';
  static String get apiPort => dotenv.env['API_PORT'] ?? '80';
  static String get CSRFToken =>
      dotenv.env['CSRF_BACKEND_TOKEN'] ?? "CSRF_TOKEN";
  static String get authorizationToken =>
      dotenv.env['AUTHORIZATION_TOKEN'] ?? 'AUTHORIZATION';
}
