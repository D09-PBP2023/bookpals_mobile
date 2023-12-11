// ignore: file_names
import 'dart:convert';

import '../../environments/endpoints.dart';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String name;
  String author;
  String originalLanguage;
  int yearPublished;
  int sales;
  String genre;
  String coverImage;

  Fields({
    required this.name,
    required this.author,
    required this.originalLanguage,
    required this.yearPublished,
    required this.sales,
    required this.genre,
    required this.coverImage,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        author: json["author"],
        originalLanguage: json["original_language"],
        yearPublished: json["year_published"],
        sales: json["sales"],
        genre: json["genre"],
        coverImage: '${Endpoints.baseUrl}/media/${json["cover_image"]}/',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "original_language": originalLanguage,
        "year_published": yearPublished,
        "sales": sales,
        "genre": genre,
        "cover_image": coverImage,
      };
}

// ignore: constant_identifier_names
enum Model { MAIN_BOOK }

final modelValues = EnumValues({"main.book": Model.MAIN_BOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
