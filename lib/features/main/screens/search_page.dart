import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/book.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/search_field.dart';
import '../../../core/theme/color_theme.dart';
import 'widgets/book_display.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _result = <Book>[];
  List<Book> _resultShown = <Book>[];
  DateTime? _lastSearchTime;
  String? _lastSearchText;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() async {
      String text = _searchController.text;
      DateTime now = DateTime.now();

      if (text == _lastSearchText) return;

      setState(() {
        _result.clear();
        _isLoading = true;
      });

      _lastSearchTime = now;
      await Future.delayed(const Duration(seconds: 1));

      if (now == _lastSearchTime && text != _lastSearchText) {
        _lastSearchText = text;
        BookProvider bookProvider = context.read<BookProvider>();

        bookProvider.searchBook(text).then((value) {
          setState(() {
            _isLoading = false;
            _result = value;
            _resultShown = _result.sublist(0, min(_result.length, 20));
          });
        });
      }
    });
  }

  Future<void> loadMoreBooks() async {
    setState(() {
      _isLoading = true;
    });
    setState(() {
      _resultShown.addAll(_result.sublist(
          _resultShown.length, min(_result.length, _resultShown.length + 20)));
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 130);
    return BpScaffold(
      body: SafeArea(
        child: LazyLoadScrollView(
          onEndOfPage: loadMoreBooks,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: const BoxDecoration(
                          color: ColorTheme.almondDust,
                        ),
                      ),
                      Positioned.fill(
                        top: 10,
                        left: 10,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        bottom: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Search",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: BookpalsSearchField(
                                title: "Search your books here..",
                                hint: "Title, artist, etc..",
                                controller: _searchController,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      (_resultShown.length + bookColumn - 1) ~/ bookColumn,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < bookColumn; i++)
                          if (index * bookColumn + i < _resultShown.length)
                            BookDisplay(
                                book: _resultShown[index * bookColumn + i]),
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
      ),
    );
  }
}
