import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/providers/profile_provider.dart';

class ListRequestPage extends StatefulWidget {
  const ListRequestPage({super.key});

  @override
  State<ListRequestPage> createState() => _ListRequestPageState();
}

class _ListRequestPageState extends State<ListRequestPage> {
  @override
  void initState() {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    profileProvider.setUserProfile();
    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.fetchAllBook();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    return ListView.builder(
      itemCount: bookProvider.listBook.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(bookProvider.listBook[index].fields.name),
          // Add more customization as needed
        );
      },
    );
  }
}
