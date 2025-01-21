class User {
  final int id;
  final String login;
  final String avatar;
  final String userName;
  final String cookies;

  User({
    required this.id,
    required this.login,
    required this.avatar,
    required this.userName,
    required this.cookies,
  });

  User copyWith({
    int? id,
    String? login,
    String? avatar,
    String? userName,
    String? cookies,
  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      avatar: avatar ?? this.avatar,
      userName: userName ?? this.userName,
      cookies: cookies ?? this.cookies,
    );
  }
}
