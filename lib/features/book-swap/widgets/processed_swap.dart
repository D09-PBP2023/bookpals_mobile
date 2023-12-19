import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/search_field.dart';
import '../../main/screens/home_page.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../screens/book_swap.dart';
import '../../main/screens/search_page.dart';
import 'card/processed_swap_card.dart';

class ProcessedSwapWidget extends StatefulWidget {
  //Override Key
  const ProcessedSwapWidget({super.key});

  @override
  State<ProcessedSwapWidget> createState() => _ProcessedSwapWidgetState();
}

class _ProcessedSwapWidgetState extends State<ProcessedSwapWidget> {
  @override
  List<Swap> _listSwaps = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      SwapProvider swapProvider = context.read<SwapProvider>();
      swapProvider.fetchProcessedSwap();
      _listSwaps = swapProvider.getProcessedSwap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final swapProvider = context.watch<SwapProvider>();

    return BpScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Back Button
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Pop to Home Page
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Processed Book Swap",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // If _listSwaps is empty, show no data
            if (_listSwaps.isEmpty)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Data"),
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
                        // Detail Data
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
                                "From: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_listSwaps[index].fields.fromUser),
                            ],
                          ),
                        ),

                        // Delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                            if (_listSwaps[index].fields.processed == true)
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Processed",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            else
                              TextButton(
                                onPressed: () {
                                  swapProvider
                                      .swapCancel(
                                          _listSwaps[index].pk.toString())
                                      .whenComplete(() {
                                    setState(() {
                                      _listSwaps.removeAt(index);
                                    });
                                  }).whenComplete(() => setState(() {
                                            swapProvider.fetchProcessedSwap();
                                          }));
                                },
                                child: const Text("Batalkan"),
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
