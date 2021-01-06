import 'package:flutter/foundation.dart';

class AuthModel with ChangeNotifier {
  bool _isAuth = true;

  void updateAuthStatus(bool auth) {
    _isAuth = auth;
    notifyListeners();
  }

  bool get isAuth => _isAuth;
}
