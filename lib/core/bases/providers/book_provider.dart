import 'dart:io';

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
    debugPrint(_listBook[0].fields.coverImage);
    notifyListeners();
  }

  Future<List<Book>> searchBook(String query) async {
    List<Book> result = [];
    if (query.isEmpty || query == "") return result;

    final response = await APIHelper.get(Endpoints.searchBooksUrl(query));
    for (var item in response) {
      result.add(Book.fromJson(item));
    }
    return result;
  }

  Future<List<Book>> searchBookByGenre(List<String> queries) async {
    List<Book> result = [];
    if (queries.isEmpty) return result;

    for (String query in queries) {
      final response =
          await APIHelper.get(Endpoints.searchBookByGenresUrl(query));
      for (var item in response) {
        result.add(Book.fromJson(item));
      }
    }
    return result.toSet().toList();
  }

  List<Book> get listBook => _listBook;

  Book getBookById(int id) {
    return _listBook.firstWhere((element) => element.pk == id);
  }

  List<Book> getRandomBooks(int count) {
    List<Book> tmp = List.from(_listBook);
    tmp.shuffle();
    return tmp.take(count).toList();
  }

  List<Book> getAllBooks() {
    return _listBook;
  }

  Book getSpecifedBook(String title) {
    // If Not Found, return Null
    Fields fields = new Fields(
        name: "",
        author: "",
        originalLanguage: "",
        yearPublished: 0,
        sales: 0,
        genre: "",
        coverImage: "");
    Book empty = new Book(model: Model.MAIN_BOOK, pk: 0, fields: fields);
    return _listBook.firstWhere((element) => element.fields.name == title,
        orElse: () => empty);
  }
}
