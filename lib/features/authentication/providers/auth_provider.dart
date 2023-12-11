import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool get signedIn => APIHelper.isSignedIn();

  Future<dynamic> signIn(String username, String password) async {
    return await APIHelper.login(Endpoints.loginUrl, {
      'username': username,
      'password': password,
    });
  }

  Future<dynamic> signUp(
      String username, String password, String password2) async {
    return await APIHelper.post(Endpoints.registerUrl, {
      'username': username,
      'password1': password,
      'password2': password2,
    });
  }

  Future<dynamic> logout() async {
    return await APIHelper.logout(Endpoints.logoutUrl);
  }
}
