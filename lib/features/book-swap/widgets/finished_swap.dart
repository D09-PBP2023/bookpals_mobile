import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../../../features/book-swap/widgets/card/processed_swap_card.dart';

class FinishedSwapWidget extends StatefulWidget {
  //Override Key
  const FinishedSwapWidget({super.key});

  @override
  State<FinishedSwapWidget> createState() => _FinishedSwapWidgetState();
}

class _FinishedSwapWidgetState extends State<FinishedSwapWidget> {
  List<Swap> _listSwaps = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      SwapProvider swapProvider = context.read<SwapProvider>();
      swapProvider.fetchFinishedSwap();
      _listSwaps = swapProvider.getFinishedSwap();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Finished Book Swap",
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
                  Text("Tidak ada buku yang diterima"),
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
                        // Finished Text
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
