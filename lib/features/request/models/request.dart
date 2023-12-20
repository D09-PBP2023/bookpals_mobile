// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

List<Request> requestFromJson(String str) => List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
    Model model;
    int pk;
    Fields fields;

    Request({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
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
    DateTime requestDateAdded;
    int user;
    RequestStatus requestStatus;

    Fields({
        required this.name,
        required this.author,
        required this.originalLanguage,
        required this.yearPublished,
        required this.sales,
        required this.genre,
        required this.coverImage,
        required this.requestDateAdded,
        required this.user,
        required this.requestStatus,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        author: json["author"],
        originalLanguage: json["original_language"],
        yearPublished: json["year_published"],
        sales: json["sales"],
        genre: json["genre"],
        coverImage: json["cover_image"],
        requestDateAdded: DateTime.parse(json["request_date_added"]),
        user: json["user"],
        requestStatus: requestStatusValues.map[json["request_status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "original_language": originalLanguage,
        "year_published": yearPublished,
        "sales": sales,
        "genre": genre,
        "cover_image": coverImage,
        "request_date_added": requestDateAdded.toIso8601String(),
        "user": user,
        "request_status": requestStatusValues.reverse[requestStatus],
    };
}

enum RequestStatus {
    APPROVED,
    REJECTED
}

final requestStatusValues = EnumValues({
    "APPROVED": RequestStatus.APPROVED,
    "REJECTED": RequestStatus.REJECTED
});

enum Model {
    BOOK_REQUEST_REQUESTBOOK
}

final modelValues = EnumValues({
    "book_request.requestbook": Model.BOOK_REQUEST_REQUESTBOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}