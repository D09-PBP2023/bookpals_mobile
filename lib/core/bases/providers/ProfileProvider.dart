import 'package:flutter/material.dart';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/Profile.dart';

import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  Map<String, dynamic> _userProfile = {};

  Map<String, dynamic> get userProfile => _userProfile;

  Future<void> setUserProfile() async {
    final response = await APIHelper.get(Endpoints.getProfile);
    _userProfile = response[0];
    print(_userProfile);
    notifyListeners();
  }
}
