import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class BookRequestProvider with ChangeNotifier{
  // TODO: tambahin field coverImage di parameter
  Future<dynamic> makeRequest(String bookName, String author, String originalLanguage, int yearPublished, int sales, String genre) async{
    return await APIHelper.post(Endpoints.addBookRequestUrl) {
    'name': bookName,
    'author': author,
    'original_language': originalLanguage,
    'year_published': yearPublished,
    'sales': sales,
    'genre': genre,
    // TODO: 'cover_image': coverImage
  }
}