import 'cookie_request.dart';

class APIHelper {
  static CookieRequest cookieRequest = CookieRequest();

  static Future<void> init() async {
    await cookieRequest.init();
  }

  static Future<dynamic> login(String url, dynamic data) async {
    return await cookieRequest.login(url, data);
  }

  static Future<dynamic> logout(String url) async {
    return await cookieRequest.logout(url);
  }

  static bool isSignedIn() {
    return cookieRequest.loggedIn;
  }

  static Future<dynamic> get(String url) async {
    return await cookieRequest.get(url);
  }

  static Future<dynamic> post(String url, dynamic data) async {
    return await cookieRequest.post(url, data);
  }
}
