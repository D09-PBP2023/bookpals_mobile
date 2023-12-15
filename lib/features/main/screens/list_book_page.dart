import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';
import 'widgets/book_display.dart';

class ListBookPage extends StatefulWidget {
  final String title;
  final List<String> queries;
  const ListBookPage({super.key, required this.title, required this.queries});

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  List<Book> _result = <Book>[];
  List<Book> _resultShown = <Book>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.searchBookByGenre(widget.queries).then((value) {
      setState(() {
        _isLoading = false;
        _result = value;
        _resultShown = _result.sublist(0, min(_result.length, 20));
      });
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
    final BookProvider bookProvider = context.watch<BookProvider>();
    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 130);
    return BpScaffold(
      usePadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                    Positioned.fill(
                      bottom: 40,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Colors.white,
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
                itemCount: (_resultShown.length + bookColumn - 1) ~/ bookColumn,
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
              // _isLoading
              //     ? SizedBox(
              //         height: MediaQuery.of(context).size.height - 200,
              //         child: const Center(child: CircularProgressIndicator()))
              //     : ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: _result.length,
              //         itemBuilder: (context, index) {
              //           return Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               for (int i = 0; i < bookColumn; i++)
              //                 if (index * bookColumn + i < _result.length)
              //                   BookDisplay(
              //                       book: _result[index * bookColumn + i]),
              //             ],
              //           );
              //         },
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
