import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class BookRequestProvider with ChangeNotifier {
  Future<dynamic> makeRequest(
      String bookName,
      String author,
      String originalLanguage,
      String yearPublished,
      String sales,
      String genre,
      CroppedFile coverImage) async {
    return await APIHelper.postWithFiles(Endpoints.addBookRequestUrl, {
      'name': bookName,
      'author': author,
      'original_language': originalLanguage,
      'year_published': yearPublished,
      'sales': sales,
      'genre': genre,
    }, [
      MultipartFile.fromBytes(
        'cover_image',
        await coverImage.readAsBytes(),
        filename: "cover_$bookName.jpg",
      )
    ]);
  }
}