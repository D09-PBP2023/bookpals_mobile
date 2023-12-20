import 'package:flutter/material.dart';
import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/book.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(
      model: "",
      pk: 0,
      fields: FieldsProfile(
        user: 0,
        nickname: "",
        email: "youremail@email.com",
        profilePicture: "",
        bio: "This client has yet to make a signature.",
        timesSwapped: 0,
        favoriteBook1: -1,
        favoriteBook2: -1,
        favoriteBook3: -1,
        bookmarkedbooks: [],
      ));

  UserProfile get userProfile => _userProfile;

  Future<void> setUserProfile() async {
    final response = await APIHelper.get(Endpoints.getProfile);
    _userProfile = UserProfile.fromJson(response[0]);
    notifyListeners();
  }

  // Future<List<Book>> getBookmarkedBooks(List<Book> allBook) async {
  //   List<Book> tmp = [];
  //   for (int i in _userProfile.fields.bookmarkedbooks) {
  //     tmp.add(allBook[i]);
  //   }
  //   return tmp;
  // }

  List<Book> bookmarked = [];

  Future<void> getBookmarkedBooks(List<Book> allBook) async {
    final response = await APIHelper.get(Endpoints.getProfile);
    bookmarked = [];
    _userProfile = UserProfile.fromJson(response[0]);
    for (Book i in allBook) {
      if (_userProfile.fields.bookmarkedbooks.contains(i.pk)) bookmarked.add(i);
    }
    notifyListeners();
  }

  Future<dynamic> editUserProfile(
      String nickname, String email, String bio) async {
    return await APIHelper.post(Endpoints.editProfile, {
      'nickname': nickname,
      'email': email,
      'bio': bio,
    });
  }

  Future<dynamic> editFavourite(int favouriteId, int x) async {
    String favoriteBookid = favouriteId.toString();
    if (x == 1) {
      return await APIHelper.post(Endpoints.editFav(x), {
        'fav1': favoriteBookid,
      });
    }
    if (x == 2) {
      return await APIHelper.post(Endpoints.editFav(x), {
        'fav2': favoriteBookid,
      });
    }
    if (x == 3) {
      return await APIHelper.post(Endpoints.editFav(x), {
        'fav3': favoriteBookid,
      });
    }

    // Future<dynamic> bookmark(int id) async {
    //   return await APIHelper.post(Endpoints.bookmarkUrl, {
    //     'book': id,
    //   });
    // }
  }

  Future<void> bookmark(int id) async {
    await APIHelper.get(Endpoints.bookmarkUrl(id));
  }
}
