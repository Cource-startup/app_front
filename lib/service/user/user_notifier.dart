import 'package:app_front/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          id: 0,
          login: '',
          avatar: '',
          userName: '',
          sessionToken: '',
          googleSignInAccount: null, // Start with null
        ));

  // Update id
  void updateId(int id) {
    state = state.copyWith(id: id);
  }

  // Update login
  void updateLogin(String login) {
    state = state.copyWith(login: login);
  }

  // Update login
  void updateUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

      // Update session token
  void updateAvatar(String sessionToken) {
    state = state.copyWith(sessionToken: sessionToken);
  }

  // Update session token
  void updateSessionToken(String sessionToken) {
    state = state.copyWith(sessionToken: sessionToken);
  }

}
