import 'dart:convert';
import 'package:app_front/handler/cookie_handler.dart';
import 'package:app_front/handler/hashing_handler.dart';
import 'package:app_front/service/error/error_state_provider.dart';
import 'package:app_front/setting/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiRequestHandler {
  final String baseUrl = '${Config.apiUrl}:${Config.apiPort}';
  final CookieHandler cookieHandler;

  ApiRequestHandler(this.cookieHandler);

  Map<String, String> _buildHeaders({bool isJson = false}) {
    final Map<String, String> headers = {
      'CSRF-Token': HashHandler.hashToken(Config.CSRFToken),
    };

    final cookieHeader = cookieHandler.cookies;
    if (cookieHeader.isNotEmpty) {
      headers['Cookie'] = cookieHeader;
    }

    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }

    return headers;
  }

  Future<http.Response?> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _buildHeaders();

    return await _handleRequest(() => http.get(url, headers: headers));
  }

  Future<http.Response?> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _buildHeaders(isJson: true);

    return await _handleRequest(() => http.post(url, headers: headers, body: json.encode(body)));
  }

  Future<http.Response?> _handleRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request();
      cookieHandler.saveCookies(response);
      return response;
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }
}
