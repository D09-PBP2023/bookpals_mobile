import 'package:flutter/material.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../widgets/accepted_swap.dart';
import '../widgets/processed_swap.dart';
import '../widgets/waiting_swap.dart';
import '../widgets/finished_swap.dart';
import 'book_swap_request.dart';
import '../../book-swap/providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../../book-swap/models/swap.dart';

class BookSwap extends StatefulWidget {
  const BookSwap({super.key});

  @override
  State<BookSwap> createState() => _BookSwapState();
}

class _BookSwapState extends State<BookSwap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BpScaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Book Swap",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BpButton(
              text: 'Request Swap',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestSwap()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "My Swap",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BpButton(
              text: 'Processed Swap List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProcessedSwapWidget()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BpButton(
              text: 'Waiting Swap List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WaitingSwapWidget()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BpButton(
              text: 'Accepted Swap List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AcceptedSwapWidget()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BpButton(
              text: 'Finished Swap List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinishedSwapWidget()),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}