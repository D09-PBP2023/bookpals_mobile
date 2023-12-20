import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class BookRequestProvider with ChangeNotifier {
  // TODO: tambahin field coverImage di parameter
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

// Harus sinkron, kalo string string, tadi kalo dibikin as int di provider juga int
// Kalau di python waktu itu saya int sihh pak, kirain bisaa string as int gituu
// Kalo di backend biasanya bakal otomatis convert tapi coba aja dulu