import 'package:flutter/material.dart';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/Book.dart';
import '../models/Profile.dart';
import 'BookProvider.dart';
import 'package:flutter/material.dart';

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
        favoriteBook1: 0,
        favoriteBook2: 0,
        favoriteBook3: 0,
        bookmarkedbooks: [],
      )
    );

  UserProfile get userProfile => _userProfile;

  Future<void> setUserProfile() async {
    final response = await APIHelper.get(Endpoints.getProfile);
    print("ini respon");
    print(response);
    print(_userProfile);
    _userProfile = UserProfile.fromJson(response[0]);
    // print(_userProfile);
    notifyListeners();
  }

  List<Book> allBook = BookProvider().listBook;

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
    for (Book i in allBook ) {
      if (_userProfile.fields.bookmarkedbooks.contains(i.pk)) bookmarked.add(i);
    }
    debugPrint(bookmarked[0].fields.name);
    notifyListeners();
  }

  // Future<dynamic> bookmark(int id) async {
  //   return await APIHelper.post(Endpoints.bookmarkUrl, {
  //     'book': id,
  //   });
  // }

  Future<void> bookmark(int id) async {
    await APIHelper.get(Endpoints.bookmarkUrl(id));
  }

}
