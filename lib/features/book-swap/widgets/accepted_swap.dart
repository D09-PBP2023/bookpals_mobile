import 'package:flutter/material.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/search_field.dart';
import '../../main/screens/home_page.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../screens/book_swap.dart';
import '../../../features/book-swap/widgets/card/processed_swap_card.dart';

class AcceptedSwapWidget extends StatefulWidget {
  //Override Key
  const AcceptedSwapWidget({super.key});

  @override
  State<AcceptedSwapWidget> createState() => _AcceptedSwapWidgetState();
}

class _AcceptedSwapWidgetState extends State<AcceptedSwapWidget> {
  @override
  List<Swap> _listSwaps = [];
  String _searchController = "";

  void initState() {
    super.initState();
    setState(() {
      SwapProvider swapProvider = context.read<SwapProvider>();
      swapProvider.fetchAcceptedSwap();
      _listSwaps = swapProvider.getAcceptedSwap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final swapProvider = context.watch<SwapProvider>();

    return BpScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Pop to Home Page
                    Navigator.pop(context);
                    setState(() {
                      swapProvider.fetchAcceptedSwap();
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Accepted Book Swap",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // If _listSwaps is empty, reload data
            if (_listSwaps.isEmpty)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tidak ada data"),
                ],
              )
            else // If _listSwaps is not empty, show the data
              ListView.builder(
                shrinkWrap: true,
                itemCount: _listSwaps.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Wanted Book: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_listSwaps[index].fields.wantBook),
                              const Text(
                                "Sender Book: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              if (_listSwaps[index].fields.haveBook == "")
                                Text("-")
                              else
                                Text(_listSwaps[index].fields.haveBook),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              const Text(
                                "Accepter: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_listSwaps[index].fields.toUser),
                            ],
                          ),
                        ),
                        // Delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Show Message Dialog
                            ElevatedButton(
                                onPressed: () {
                                  // Navigate to ProcessedCard
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProcessedCard(
                                              swap: _listSwaps[index])));
                                },
                                child: Icon(Icons.info)),
                            ElevatedButton(
                              onPressed: () {
                                swapProvider
                                    .swapFinished(
                                        _listSwaps[index].pk.toString())
                                    .whenComplete(() {
                                  setState(() {
                                    _listSwaps.removeAt(index);
                                  });
                                }).whenComplete(() => setState(() {
                                          swapProvider.fetchAcceptedSwap();
                                        }));
                              },
                              child: const Text("Selesaikan"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

            // Show Data
          ],
        ),
      ),
    );
  }
}
