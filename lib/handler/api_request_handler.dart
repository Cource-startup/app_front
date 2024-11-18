import 'dart:convert';
import 'package:app_front/handler/hashing_handler.dart';
import 'package:app_front/setting/config.dart';
import 'package:http/http.dart' as http;

class ApiRequestHandler {
  final String baseUrl = '${Config.apiUrl}:${Config.apiPort}';

  Map<String, String> _buildHeaders({bool isJson = false}) {
    final headers = {
      'X-CSRF-Token': HashHandler.hashToken(Config.CSRFToken),
      'Authorization': Config.authorizationToken,
    };

    // Add Content-Type only for POST and PUT requests
    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }

    return headers;
  }

  Future<http.Response?> _handleRequest(
    Future<http.Response> Function() request, {
    void Function(String error)? onError,
  }) async {
    try {
      final response = await request();

      if (response.statusCode >= 500) {
        onError?.call('An error occurred. Please try again.');
      }

      if (Config.isDebugMode) {
        print('Request URL: ${response.request?.url}');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      return response;
    } catch (e) {
      if (Config.isDebugMode) {
        print('Request Error: $e');
      }
      onError?.call('Failed to complete the request.');
      return null;
    }
  }

  Future<http.Response?> get(String endpoint,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(() => http.get(url, headers: _buildHeaders()),
        onError: onError);
  }

  Future<http.Response?> post(String endpoint, Map<String, dynamic> body,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.post(url,
          headers: _buildHeaders(isJson: true), body: json.encode(body)),
      onError: onError,
    );
  }

  Future<http.Response?> put(String endpoint, Map<String, dynamic> body,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.put(url,
          headers: _buildHeaders(isJson: true), body: json.encode(body)),
      onError: onError,
    );
  }

  Future<http.Response?> delete(String endpoint,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(() => http.delete(url, headers: _buildHeaders()),
        onError: onError);
  }
}
