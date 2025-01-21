import 'dart:convert';
import 'dart:io';
import 'package:app_front/core/debug_printer.dart';
import 'package:app_front/handler/cookie_handler.dart';
import 'package:app_front/handler/hashing_handler.dart';
import 'package:app_front/service/error/error_state_provider.dart';
import 'package:app_front/setting/config.dart';
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

  Future<http.Response?> post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      DebugPrinter.log("Request body: ${json.encode(body)}",
          tag: "API_REQUEST");
      return _handleRequest(() => http.post(
            Uri.parse(baseUrl + endpoint),
            headers: _buildHeaders(isJson: true),
            body: json.encode(body),
          ));
    } catch (e) {
      print('Error making POST request: $e');
      return null;
    }
  }

  Future<http.Response?> _handleRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      cookieHandler.saveCookies(response);

      DebugPrinter.log("Response Status Code: ${response.statusCode}",
          tag: "API_RESPONSE");
      DebugPrinter.log("Response Body: ${response.body}", tag: "API_RESPONSE");
      DebugPrinter.log("Response Headers: ${response.headers}",
          tag: "API_RESPONSE");

      // if (response.statusCode >= 500 || responseBody['error'] != null) {
      //   if (responseBody['error'] is Map &&
      //       responseBody['error']['user_notification'] != null) {
      //     // Update global error state with user notification
      //     ref
      //         .read(errorStateProvider.notifier)
      //         .showError(responseBody['error']['user_notification']);
      //   } else {
      //     // Update global error state with a generic error message
      //     ref
      //         .read(errorStateProvider.notifier)
      //         .showError("An unexpected error occurred.");
      //   }
      // }

      return response;
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }

  Future<http.Response?> uploadFile(String endpoint, File file,
      {required String fieldName}) async {
    try {
      DebugPrinter.log("Request url: $baseUrl$endpoint", tag: "API_REQUEST");
      DebugPrinter.log("Request file: ${file.path} ($fieldName)", tag: "API_REQUEST");

      final request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl$endpoint'))
        ..headers.addAll(_buildHeaders())
        ..files.add(await http.MultipartFile.fromPath(fieldName, file.path));

      final streamedResponse = await request.send();
      
      return _handleRequest(() => http.Response.fromStream(streamedResponse));
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<http.Response?> downloadFile(String url) async {
    try {
      return await http.get(Uri.parse(url));
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }
}
