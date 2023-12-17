import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/BookProvider.dart';
import '../../../core/bases/providers/ProfileProvider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../main/screens/widgets/book_display.dart';
import 'displayEdit.dart';

class BookmarkEdit extends StatefulWidget {
  final ProfileProvider profileProvider;
  final int x;
  const BookmarkEdit(
      {super.key, required this.profileProvider, required this.x});

  @override
  State<BookmarkEdit> createState() => _BookmarkEditState();
}

class _BookmarkEditState extends State<BookmarkEdit> {
  @override
  void initState() {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    profileProvider.setUserProfile();
    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.fetchAllBook();
    List<Book> allBook = bookProvider.listBook;
    profileProvider.getBookmarkedBooks(allBook);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final bookProvider = context.watch<BookProvider>();
    List<Book> featuredBooks = bookProvider.getRandomBooks(10);
    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 150);

    return BpScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Find More Books!",
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
                "Bookmarked",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: (profileProvider.bookmarked.length + bookColumn - 1) ~/
                  bookColumn,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < bookColumn; i++)
                      if (index * bookColumn + i <
                          profileProvider.bookmarked.length)
                        displayEdit(
                          book: profileProvider
                              .bookmarked[index * bookColumn + i],
                          profileProvider: profileProvider,
                          x: widget.x,
                        ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
