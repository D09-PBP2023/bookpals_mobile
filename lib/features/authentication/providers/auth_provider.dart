import 'package:bookpals_mobile/core/environments/endpoints.dart';
import 'package:bookpals_mobile/services/api.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool get signedIn => APIHelper.isSignedIn();

  Future<dynamic> signIn(String username, String password) async {
    return await APIHelper.login(Endpoints.loginUrl, {
      'username': username,
      'password': password,
    });
  }

  Future<dynamic> logout() async {
    return await APIHelper.logout(Endpoints.logoutUrl);
  }
}
