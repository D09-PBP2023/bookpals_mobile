// To parse this JSON data, do
//
//     final swap = swapFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Swap> swapFromJson(String str) =>
    List<Swap>.from(json.decode(str).map((x) => Swap.fromJson(x)));

String swapToJson(List<Swap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Swap {
  String model;
  int pk;
  Fields fields;

  Swap({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Swap.fromJson(Map<String, dynamic> json) => Swap(
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
  String fromUser;
  String toUser;
  String haveBook;
  String wantBook;
  String fromMessage;
  String toMessage;
  bool processed;
  bool swapped;

  Fields({
    required this.fromUser,
    required this.toUser,
    required this.haveBook,
    required this.wantBook,
    required this.fromMessage,
    required this.toMessage,
    required this.processed,
    required this.swapped,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        fromUser: json["from_user"],
        toUser: json["to_user"],
        haveBook: json["have_book"],
        wantBook: json["want_book"],
        fromMessage: json["from_message"],
        toMessage: json["to_message"],
        processed: json["processed"],
        swapped: json["swapped"],
      );

  Map<String, dynamic> toJson() => {
        "from_user": fromUser,
        "to_user": toUser,
        "have_book": haveBook,
        "want_book": wantBook,
        "from_message": fromMessage,
        "to_message": toMessage,
        "processed": processed,
        "swapped": swapped,
      };
}
