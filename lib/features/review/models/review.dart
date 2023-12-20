// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  int id;
  int book;
  String user;
  String review;
  int rating;
  DateTime created_at;

  Review({
    required this.id,
    required this.book,
    required this.user,
    required this.review,
    required this.rating,
    required this.created_at,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        book: json["book"],
        user: json["user"],
        review: json["review"],
        rating: json["rating"],
        created_at: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book": book,
        "user": user,
        "review": review,
        "rating": rating,
        "created_at": created_at.toIso8601String(),
      };
}
