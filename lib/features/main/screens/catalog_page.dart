import 'dart:math';

import 'package:bookpals_mobile/features/main/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/ProfileProvider.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/widgets/custom_icon_icons.dart';
import '../../../core/bases/widgets/scaffold.dart';
import 'widgets/book_display.dart';
import 'widgets/category_display.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool _isLoading = true;
  List<Book> exploreBooks = [];
  List<CategoryDisplay> categories = const [
    CategoryDisplay(
      icon: Icon(
        CustomIcon.heart,
        size: 18,
        color: Colors.red,
      ),
      label: "Romance",
      queries: ["Romance", "Love", "Romantic"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.fast_ship,
        size: 18,
        color: Colors.blue,
      ),
      label: "Fiction",
      queries: ["Fiction"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.leaf,
        size: 18,
        color: Colors.green,
      ),
      label: "Adventure",
      queries: ["Adventure"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.book_open,
        size: 18,
        color: Colors.brown,
      ),
      label: "Novel",
      queries: ["Novel"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.knife,
        size: 18,
        color: Colors.red,
      ),
      label: "Thriller",
      queries: ["Thriller"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.hand_holding_heart,
        size: 18,
        color: Colors.pink,
      ),
      label: "Self-help",
      queries: ["Self-help"],
    ),
    CategoryDisplay(
      icon: Icon(
        CustomIcon.magic,
        size: 18,
        color: Colors.purple,
      ),
      label: "Fantasy",
      queries: ["Fantasy"],
    ),
  ];

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
    List<Book> featuredBooks = bookProvider.getRandomBooks(20);
    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 130);

    final profileProvider = context.read<ProfileProvider>();
    profileProvider.getBookmarkedBooks(bookProvider.listBook);

    return BpScaffold(
      body: LazyLoadScrollView(
        onEndOfPage: loadMoreBooks,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CustomIcon.book_open,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Bookpals",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SearchPage();
                        }));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: (categories.length + 1) ~/ 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        categories[2 * index],
                        if (2 * index + 1 < categories.length)
                          categories[2 * index + 1],
                      ],
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "For You",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: (exploreBooks.length + bookColumn - 1) ~/ bookColumn,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < bookColumn; i++)
                        if (index * bookColumn + i < exploreBooks.length)
                          BookDisplay(
                              book: exploreBooks[index * bookColumn + i]),
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
