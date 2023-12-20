import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class SubmitBookRequestProvider with ChangeNotifier {
  Future<dynamic> submitRequest(
      String bookName,
      String author,
      String originalLanguage,
      String yearPublished,
      String sales,
      String genre) async {
    return await APIHelper.post(Endpoints.addBookRequestUrl, {
      'name': bookName,
      'author': author,
      'original_language': originalLanguage,
      'year_published': yearPublished,
      'sales': sales,
      'genre': genre,
    });
  }
}