import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/bases/models/book.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/providers/profile_provider.dart';
import '../../../core/bases/widgets/custom_icon_icons.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../main/screens/search_page.dart';
import '../../main/screens/widgets/book_display.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  bool _isLoading = true;
  List<Book> featuredBooks = [];

  @override
  void initState() {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    BookProvider bookProvider = context.read<BookProvider>();

    profileProvider.setUserProfile().then((value) {
      setState(() {
        featuredBooks = bookProvider.getRandomBooks(10);
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    int sumBookmarked = profileProvider.bookmarked.length;

    final bookColumn = ((MediaQuery.of(context).size.width - 100) ~/ 130);

    return BpScaffold(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      body: SingleChildScrollView(
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
                "Find More Books!",
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bookmarked $sumBookmarked books:",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            if (profileProvider.bookmarked.isEmpty)
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "No Books Here Yet...\nLet's Find More Books!",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              )
            else
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      (profileProvider.bookmarked.length + bookColumn - 1) ~/
                          bookColumn,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < bookColumn; i++)
                          if (index * bookColumn + i <
                              profileProvider.bookmarked.length)
                            BookDisplay(
                                book: profileProvider
                                    .bookmarked[index * bookColumn + i]),
                      ],
                    );
                  }),
            Offstage(
              offstage: !_isLoading,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
