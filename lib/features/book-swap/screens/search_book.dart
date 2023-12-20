import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  @override
  Widget build(BuildContext context) {
    return const BpScaffold(
        body: Center(
      child: Text('Search Book'),
    ));
  }
}
