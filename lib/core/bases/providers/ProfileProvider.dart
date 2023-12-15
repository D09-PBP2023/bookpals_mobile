import 'package:flutter/material.dart';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/Profile.dart';

class ProfileProvider with ChangeNotifier {
  final String _name = "joey";
  Future<UserProfile> getProfile() async {
    final response = await APIHelper.get(Endpoints.getProfile);
    return response;
  }

  String get name => _name;
}
