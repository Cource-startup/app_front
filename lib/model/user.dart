import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String id;
  final String login;
  final String sessionToken;
  final GoogleSignInAccount? googleSignInAccount;

  User({
    required this.id,
    required this.login,
    required this.sessionToken,
    this.googleSignInAccount, // Start with null as the initial value
  });

  // A copyWith method to create modified copies of User
  User copyWith({
    String? id,
    String? login,
    String? sessionToken,
    GoogleSignInAccount? googleSignInAccount,
  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      sessionToken: sessionToken ?? this.sessionToken,
      googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
    );
  }
}
