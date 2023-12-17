import 'package:flutter/material.dart';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/Profile.dart';

class ProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(
      model: "",
      pk: 0,
      fields: Fields(
        user: 0,
        nickname: "",
        email: "youremail@email.com",
        profilePicture: "",
        bio: "This client has yet to make a signature.",
        timesSwapped: 0,
        favoriteBook1: 0,
        favoriteBook2: 0,
        favoriteBook3: 0,
        bookmarkedbooks: [],
      ));

  UserProfile get userProfile => _userProfile;

  Future<void> setUserProfile() async {
    final response = await APIHelper.get(Endpoints.getProfile);
    print(response[0]);
    _userProfile = UserProfile.fromJson(response[0]);
    print(_userProfile.fields);
    notifyListeners();
  }

  Future<dynamic> edit_userprofile(
      String nickname, String email, String bio) async {
    return await APIHelper.post(Endpoints.editProfile, {
      'nickname': nickname,
      'email': email,
      'bio': bio,
    });
  }
}
