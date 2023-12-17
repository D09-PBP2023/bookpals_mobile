import 'package:flutter/material.dart';

import '../../../../core/bases/models/Book.dart';

import '../../../core/bases/providers/ProfileProvider.dart';
import '../../book_details/screens/book_page.dart';
import '../../main/screens/home_page.dart';

class displayEdit extends StatelessWidget {
  final int x;
  final Book book;
  final ProfileProvider profileProvider;
  const displayEdit(
      {super.key,
      required this.book,
      required this.profileProvider,
      required this.x});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        profileProvider.edit_fav(book.pk, x);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        height: 300,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              book.fields.coverImage,
              width: 130,
              height: 130 / 9 * 14,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            book.fields.name,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // child: Text('Go to book detail page'
        ]),
      ),
    );
  }
}

// ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BookDetailPage(book)),
//             );
//           }, 