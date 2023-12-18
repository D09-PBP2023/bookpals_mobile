// Book_detail_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/book.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/providers/profile_provider.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage(this.book, {super.key});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final Color _bookmarkColor = const Color(0xFF0148A4);
  IconData _icon = Icons.bookmark_outline;

  Widget get bookProfile {
    @override
    void initState() {
      print(widget.book.fields.name);
      print(widget.book.pk);
      ProfileProvider profileProvider = context.read<ProfileProvider>();
      profileProvider.setUserProfile();
      BookProvider bookProvider = context.read<BookProvider>();
      bookProvider.fetchAllBook();
      List<Book> allBook = bookProvider.listBook;
      profileProvider.getBookmarkedBooks(allBook);
      if (profileProvider.bookmarked.contains(widget.book)) {
        _icon = Icons.bookmark;
      } else {
        _icon = Icons.bookmark_outline;
      }
      super.initState();
    }

    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.book.fields.coverImage,
                width: 225,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10.0)),
          Center(
            child: Text(
              '${widget.book.fields.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32.0, color: Colors.black),
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(
                  5, (index) => const Icon(Icons.star, color: Colors.yellow)),
            ),
          ),
          Center(
            child: Text(
              'Published: ${widget.book.fields.yearPublished}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          Center(
            child: Text(
              'Language: ${widget.book.fields.originalLanguage}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          Center(
            child: Text(
              'Genre: ${widget.book.fields.genre}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          // Adding buttons

          const Padding(padding: EdgeInsets.all(10.0)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  elevation: 15.0,
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xFF0148A4),
                  child: SizedBox(
                    width: 100.0, // specify the width
                    height: 50.0, // specify the height
                    child: MaterialButton(
                      textColor: Colors.white,
                      onPressed: () {},
                      child: const Text(
                        'Review',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(7.0)),
                Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(5.0),
                  // color: _bookmarkColor,
                  child: SizedBox(
                    width: 50.0, // specify the width
                    height: 50.0, // specify the height
                    child: MaterialButton(
                      onPressed: () async {
                        var profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);
                        await profileProvider.bookmark(widget.book.pk);
                        BookProvider bookProvider =
                            context.read<BookProvider>();
                        bookProvider.fetchAllBook();
                        List<Book> allBook = bookProvider.listBook;
                        profileProvider.getBookmarkedBooks(allBook);

                        setState(() {
                          if (_icon == Icons.bookmark_outline) {
                            _icon = Icons.bookmark;
                          } else
                            _icon = Icons.bookmark_outline;
                        });
                      },
                      child: Icon(_icon, color: _bookmarkColor, weight: 50.0),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // end button
          const SizedBox(height: 32.0),
          const Center(
            child: Text(
              'Reviews',
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
          const SizedBox(height: 32.0),
          const Divider(color: Colors.grey),
          const Text(
            '© 2023 BookPals, Inc.',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  //Finally, the build method:
  //
  // Aside:
  // It's often much easier to build UI if you break up your widgets the way I
  // have in this file rather than trying to have one massive build method
  @override
  Widget build(BuildContext context) {
    // This is a new page, so you need a new Scaffold!
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Read ${widget.book.fields.name}!'),
        titleTextStyle: const TextStyle(color: Colors.black87),
      ),
      body:
          // Center(
          SingleChildScrollView(child: bookProfile),

      // ),
    );
  }
}
