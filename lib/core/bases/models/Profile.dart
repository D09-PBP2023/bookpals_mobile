// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  String model;
  int pk;
  Fields fields;

  UserProfile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String nickname;
  String email;
  String profilePicture;
  String bio;
  int timesSwapped;
  int favoriteBook1;
  int favoriteBook2;
  int favoriteBook3;
  List<int> bookmarkedbooks;

  Fields({
    required this.user,
    required this.nickname,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.timesSwapped,
    required this.favoriteBook1,
    required this.favoriteBook2,
    required this.favoriteBook3,
    required this.bookmarkedbooks,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        nickname: json["nickname"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        bio: json["bio"],
        timesSwapped: json["times_swapped"],
        favoriteBook1: json["favoriteBook1"],
        favoriteBook2: json["favoriteBook2"],
        favoriteBook3: json["favoriteBook3"],
        bookmarkedbooks: List<int>.from(json["bookmarkedbooks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "nickname": nickname,
        "email": email,
        "profile_picture": profilePicture,
        "bio": bio,
        "times_swapped": timesSwapped,
        "favoriteBook1": favoriteBook1,
        "favoriteBook2": favoriteBook2,
        "favoriteBook3": favoriteBook3,
        "bookmarkedbooks": List<dynamic>.from(bookmarkedbooks.map((x) => x)),
      };
}
