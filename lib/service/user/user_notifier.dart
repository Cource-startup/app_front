import 'package:app_front/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          id: '',
          login: '',
          sessionToken: '',
          googleSignInAccount: null, // Start with null
        ));

  // Update id
  void updateId(String id) {
    state = state.copyWith(id: id);
  }

  // Update login
  void updateLogin(String login) {
    state = state.copyWith(login: login);
  }

  // Update session token
  void updateSessionToken(String sessionToken) {
    state = state.copyWith(sessionToken: sessionToken);
  }
}
