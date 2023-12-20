import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import 'card/processed_swap_card.dart';

class ProcessedSwapWidget extends StatefulWidget {
  //Override Key
  const ProcessedSwapWidget({super.key});

  @override
  State<ProcessedSwapWidget> createState() => _ProcessedSwapWidgetState();
}

class _ProcessedSwapWidgetState extends State<ProcessedSwapWidget> {
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
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
                  icon: const Icon(Icons.arrow_back_ios),
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
                  Text("No Data"),
                ],
              )
            else // If _listSwaps is not empty, show the data
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                                const Text("-")
                              else
                                Text(_listSwaps[index].fields.haveBook),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              if (_listSwaps[index].fields.toUser == "")
                                const Text(
                                  "From: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              else
                                const Text(
                                  "Acceptor: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              if (_listSwaps[index].fields.toUser == "")
                                const Text("You")
                              else
                                Text(_listSwaps[index].fields.toUser),
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
                                child: const Icon(Icons.info)),
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
                                            swapProvider.logIn();
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
