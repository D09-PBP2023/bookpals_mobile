import 'package:flutter/material.dart';
import 'dart:convert';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';

import 'package:bookpals_mobile/features/review/models/review.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> listReview = [];
  double averageRating = 0.0;

  Future<void> fetchReview(int id) async {
    final response = await APIHelper.get(Endpoints.getReview(id));
    listReview = [];
    for (var item in response) {
      listReview.add(Review.fromJson(item));
    }
    notifyListeners();
  }

  Future<dynamic> addReview(
      String review, String rating, String bookId) async {
    return await APIHelper.post(Endpoints.addReview, {
      'review': review,
      'rating': rating,
      'book_id': bookId,
    });
  }

  Future<void> getAverageRating(int id) async {
    final response = await APIHelper.get(Endpoints.getAverageRating(id));
    if (response['average_rating'] is num) {
      averageRating = response['average_rating'];
    } else {
      averageRating = 0.0;
    }
    notifyListeners();
  }
}
