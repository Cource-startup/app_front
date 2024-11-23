import 'dart:convert';
import 'package:app_front/core/debug_printer.dart';
import 'package:app_front/handler/hashing_handler.dart';
import 'package:app_front/service/error/error_state_provider.dart';
import 'package:app_front/setting/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiRequestHandler {
  final String baseUrl = '${Config.apiUrl}:${Config.apiPort}';
  final WidgetRef ref;

  ApiRequestHandler(this.ref);

  get headers => null;

  Map<String, String> _buildHeaders({bool isJson = false}) {
    final headers = {
      'CSRF-Token': HashHandler.hashToken(Config.CSRFToken),
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
    String? url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      // Log the request details
      DebugPrinter.log("Request URL: $url", tag: "API_REQUEST");
      DebugPrinter.log("Request Headers: ${jsonEncode(headers)}",
          tag: "API_REQUEST");
      if (body != null) {
        DebugPrinter.log("Request Body: ${jsonEncode(body)}",
            tag: "API_REQUEST");
      }

      final response = await request();
      // Log the response details
      DebugPrinter.log("Response Status Code: ${response.statusCode}",
          tag: "API_RESPONSE");
      DebugPrinter.log("Response Body: ${response.body}", tag: "API_RESPONSE");

      if (response.statusCode >= 500) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['error'] is Map &&
            responseBody['error']['user_notification'] != null) {
          // Update global error state with user notification
          ref
              .read(errorStateProvider.notifier)
              .showError(responseBody['error']['user_notification']);
        } else {
          // Update global error state with a generic error message
          ref
              .read(errorStateProvider.notifier)
              .showError("An unexpected error occurred.");
        }
      }

      return response;
    } catch (e) {
      // Handle unexpected errors
      DebugPrinter.error("Request failed: $e", tag: "API_ERROR");
      ref
          .read(errorStateProvider.notifier)
          .showError("Failed to complete the request.");
      return null;
    }
  }

  Future<http.Response?> get(String endpoint,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.get(url, headers: _buildHeaders()),
      url: endpoint,
      headers: headers,
    );
  }

  Future<http.Response?> post(String endpoint, Map<String, dynamic> body,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.post(url,
          headers: _buildHeaders(isJson: true), body: json.encode(body)),
      url: endpoint,
      headers: headers,
      body: body,
    );
  }

  Future<http.Response?> put(String endpoint, Map<String, dynamic> body,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.put(url,
          headers: _buildHeaders(isJson: true), body: json.encode(body)),
      url: endpoint,
      headers: headers,
      body: body,
    );
  }

  Future<http.Response?> delete(String endpoint,
      {void Function(String error)? onError}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return _handleRequest(
      () => http.delete(url, headers: _buildHeaders()),
      url: endpoint,
      headers: headers,
    );
  }
}
