import 'package:flutter/material.dart';

import '../../../../core/bases/models/Book.dart';

class BookDisplay extends StatelessWidget {
  final Book book;
  const BookDisplay({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 300,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              book.fields.coverImage,
              width: 150,
              height: 200,
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
        ],
      ),
    );
  }
}
