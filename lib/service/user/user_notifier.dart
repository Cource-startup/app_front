import 'package:app_front/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          id: 0,
          login: '',
          avatar: '',
          userName: '',
          cookies: '', // Initialize cookies with an empty string
        ));

  // Update id
  void updateId(int id) {
    state = state.copyWith(id: id);
  }

  // Update login
  void updateLogin(String login) {
    state = state.copyWith(login: login);
  }

  // Update userName
  void updateUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  // Update avatar
  void updateAvatar(String avatar) {
    state = state.copyWith(avatar: avatar);
  }

  // Update cookies
  void updateCookies(String cookies) {
    state = state.copyWith(cookies: cookies);
  }

  // Clear cookies
  void clearCookies() {
    state = state.copyWith(cookies: '');
  }
}
