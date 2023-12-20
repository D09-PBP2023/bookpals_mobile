import 'package:flutter/material.dart';
import '../../models/swap.dart';

import '../../../../core/bases/providers/book_provider.dart';
import '../../../../core/bases/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import '../../../../core/bases/models/book.dart';

class ProcessedCard extends StatelessWidget {
  const ProcessedCard({super.key, required this.swap});
  final Swap swap;

  @override
  Widget build(BuildContext context) {
    BookProvider bookProvider = context.read<BookProvider>();
    Book book1 = bookProvider.getSpecifedBook(swap.fields.wantBook);
    Book book2 = bookProvider.getSpecifedBook(swap.fields.haveBook);
    return BpScaffold(
        body: Center(
      child: Column(children: [
        // Back Button
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Pop to Home Page
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Book Swap Detail",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 130,
              height: 300,
              child: Column(
                children: [
                  const Text(
                    "Wanted Book",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      book1.fields.coverImage,
                      width: 130,
                      height: 130 / 9 * 14,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    swap.fields.wantBook,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 130,
              height: 300,
              child: Column(
                children: [
                  const Text(
                    "Owned Book",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  if (swap.fields.haveBook == "")
                    const Text("-")
                  else
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            book2.fields.coverImage,
                            width: 130,
                            height: 130 / 9 * 14,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          swap.fields.haveBook,
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  "Sender Request",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(swap.fields.fromUser),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Acceptor Request",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                if (swap.fields.toUser == "")
                  const Text("-")
                else
                  Text(swap.fields.toUser)
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  "Sender Message:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(swap.fields.fromMessage),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Acceptor Message:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                if (swap.fields.toMessage == "")
                  const Text("-")
                else
                  Text(swap.fields.toMessage)
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  "Status:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                if (swap.fields.swapped == false)
                  if (swap.fields.processed == false)
                    const Text("waiting")
                  else
                    const Text("Processed")
                else
                  const Text("Finished")
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
