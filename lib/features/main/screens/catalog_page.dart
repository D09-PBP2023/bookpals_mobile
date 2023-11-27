import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/BookProvider.dart';
import '../../../core/bases/widgets/scaffold.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.fetchAllBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    return BpScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: bookProvider.listBook.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookProvider.listBook[index].fields.name),
                  subtitle: Text(bookProvider.listBook[index].fields.author),
                  onTap: () {
                    debugPrint(
                        "Tapped ${bookProvider.listBook[index].fields.name}");
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
