import 'package:flutter/material.dart';

import '../list_book_page.dart';

class CategoryDisplay extends StatelessWidget {
  final Icon icon;
  final String label;
  final List<String> queries;
  const CategoryDisplay(
      {super.key,
      required this.icon,
      required this.label,
      required this.queries});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ListBookPage(
              title: label,
              queries: queries,
            );
          })),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 50,
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
