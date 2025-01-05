import 'package:google_sign_in/google_sign_in.dart';

class User {
  final int id;
  final String login;
  final String avatar;
  final String userName;
  final String sessionToken;
  final GoogleSignInAccount? googleSignInAccount;

  User({
    required this.id,
    required this.login,
    required this.avatar,
    required this.userName,
    required this.sessionToken,
    this.googleSignInAccount,
  });

  // A copyWith method to create modified copies of User
  User copyWith({
    int? id,
    String? login,
    String? avatar,
    String? userName,
    String? sessionToken,
  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      avatar: avatar ?? this.avatar,
      userName: userName ?? this.userName,
      sessionToken: sessionToken ?? this.sessionToken,
    );
  }
}
