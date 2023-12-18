import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/bases/models/book.dart';
import '../../../../core/bases/providers/book_provider.dart';
import '../../../../core/bases/providers/profile_provider.dart';
import '../../../../core/bases/widgets/scaffold.dart';
import '../../../../core/theme/color_theme.dart';
import 'display_edit.dart';

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
    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 150);

    return BpScaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Favourite',
        ),
        backgroundColor: ColorTheme.tanParchment,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        DisplayEdit(
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
