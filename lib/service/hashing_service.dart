import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart';

class TokenHasher {
  static Future<String> getHash() async {
    List<int> tokenBites =
        utf8.encode(dotenv.env['X_REQUESTED_WITH_TOKEN'] ?? '');
    String tokenHash = sha256.convert(tokenBites).toString();
    print("token: $tokenHash");
    return tokenHash;
  }
}
