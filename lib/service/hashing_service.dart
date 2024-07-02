import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PasswordHasher {
  static Future<String> hashPassword() async {
    final password = utf8.encode(dotenv.env['PASSWORD_TO_HASH'] ?? '');
    final salt = utf8.encode(dotenv.env['SALT'] ?? '');
    final algorithm = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );
    final newSecretKey = await algorithm.deriveKey(
      secretKey: SecretKey(password),
      nonce: salt,
    );
    return base64.encode(await newSecretKey.extractBytes());
  }
}
