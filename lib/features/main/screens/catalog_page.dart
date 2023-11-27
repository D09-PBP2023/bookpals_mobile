import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/BookProvider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import 'widgets/book_display.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool _isLoading = true;
  List<Book> exploreBooks = [];
  @override
  void initState() {
    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.fetchAllBook().then((value) {
      setState(() {
        exploreBooks = bookProvider.listBook.sublist(0, 20);
        _isLoading = false;
      });
    });

    super.initState();
  }

  Future<void> loadMoreBooks() async {
    BookProvider bookProvider = context.read<BookProvider>();
    setState(() {
      _isLoading = true;
    });
    setState(() {
      exploreBooks.addAll(bookProvider.listBook.sublist(exploreBooks.length,
          min(bookProvider.listBook.length, exploreBooks.length + 20)));
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    List<Book> featuredBooks = bookProvider.getRandomBooks(6);

    return BpScaffold(
      body: LazyLoadScrollView(
        onEndOfPage: loadMoreBooks,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "For You",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: featuredBooks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BookDisplay(book: featuredBooks[index]),
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Explore",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                itemCount: (exploreBooks.length + 1) ~/ 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BookDisplay(book: exploreBooks[index * 2]),
                      if (index * 2 + 1 < exploreBooks.length)
                        BookDisplay(book: exploreBooks[index * 2 + 1]),
                    ],
                  );
                },
              ),
              Offstage(
                offstage: !_isLoading,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
