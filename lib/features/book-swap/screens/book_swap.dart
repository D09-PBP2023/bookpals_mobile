import 'package:flutter/material.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../widgets/processed_swap.dart';
import '../widgets/accepted_swap.dart';
import '../widgets/waiting_swap.dart';
import 'book_swap_request.dart';

class BookSwap extends StatefulWidget {
  const BookSwap({super.key});

  @override
  State<BookSwap> createState() => _BookSwapState();
}

class _BookSwapState extends State<BookSwap> {
  int _selectedIndex = 0;
  int categoriesIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> categories = <String>[
    'Processed',
    'Waiting',
    'Accept',
  ];

  final List<Widget> categoriesWidget = <Widget>[
    ProcessedSwap(),
    WaitingSwap(),
    AcceptedSwap(),
  ];

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
          Center(
            child: Container(
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: categoriesIndex == index
                              ? Colors.brown[300]
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categoriesIndex = index;
                          });
                        },
                        child: Text(categories[index]));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          categoriesWidget[categoriesIndex],
        ],
      ),
    ));
  }
}
