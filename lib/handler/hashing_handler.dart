import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashHandler {
  static String hashToken(String token) {
    List<int> tokenBites = utf8.encode(token);
    return sha256.convert(tokenBites).toString();
  }
}
