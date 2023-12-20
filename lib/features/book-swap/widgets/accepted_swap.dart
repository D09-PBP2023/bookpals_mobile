import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../../../features/book-swap/widgets/card/processed_swap_card.dart';

class AcceptedSwapWidget extends StatefulWidget {
  //Override Key
  const AcceptedSwapWidget({super.key});

  @override
  State<AcceptedSwapWidget> createState() => _AcceptedSwapWidgetState();
}

class _AcceptedSwapWidgetState extends State<AcceptedSwapWidget> {
  List<Swap> _listSwaps = [];

  @override
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
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
                  icon: const Icon(Icons.arrow_back_ios),
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
                physics: const NeverScrollableScrollPhysics(),
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
                                const Text("-")
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
                                child: const Icon(Icons.info)),
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
                                          swapProvider.logIn();
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
