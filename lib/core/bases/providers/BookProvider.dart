import 'package:flutter/material.dart';

import '../../../services/api.dart';
import '../../environments/endpoints.dart';
import '../models/Book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _listBook = [];

  Future<void> fetchAllBook() async {
    final response = await APIHelper.get(Endpoints.getBooksUrl);
    _listBook = [];
    for (var item in response) {
      _listBook.add(Book.fromJson(item));
    }
    notifyListeners();
  }

  List<Book> get listBook => _listBook;

  Book getBookById(int id) {
    return _listBook.firstWhere((element) => element.pk == id);
  }
}
