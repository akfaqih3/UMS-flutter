import '../models/user_model.dart';

class LoginController {
  User? _user;

  void login(String username, String password) {
    // Here you can add logic to authenticate the user
    _user = User(username: username, password: password);
    print('User logged in: ${_user!.username}');
  }

  User? get user => _user;
}
