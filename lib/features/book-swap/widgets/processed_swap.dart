import 'package:flutter/material.dart';

import '../../../core/bases/widgets/search_field.dart';

class ProcessedSwap extends StatefulWidget {
  const ProcessedSwap({super.key});
  @override
  State<ProcessedSwap> createState() => _ProcessedSwapState();
}

class _ProcessedSwapState extends State<ProcessedSwap> {
  String _searchTextController = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Search Filed
        TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        SizedBox(height: 20),
        //List of Book
      ],
    );
  }
}
