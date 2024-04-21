
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_front/models/auth/auth_args.dart';
import 'package:app_front/models/auth/auth_response.dart';
import 'package:app_front/models/auth/auth_values.dart';

class AuthenticationHandler {
  late AuthValues authValues = AuthValues(
    email: '',
    clientId: '',
    refreshToken: '',
    token: '',
  );

  Future<AuthResponse> login(AuthArgs args) async {
    final response = await http.post(
      Uri.http('localhost:4000', '/api/login'),
      body: {
        'email': args.email,
        'password': args.password,
        'token': 'my_token',
      },
    );
    authValues = AuthValues.fromJson(jsonDecode(response.body));
    // return response.statusCode;
    return AuthResponse(
      authValues: authValues,
      statusCode: response.statusCode,
    );
  }
}
