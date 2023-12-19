import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import 'card/processed_swap_card.dart';

class WaitingSwapWidget extends StatefulWidget {
  //Override Key
  const WaitingSwapWidget({super.key});

  @override
  State<WaitingSwapWidget> createState() => _WaitingSwapWidgetState();
}

class _WaitingSwapWidgetState extends State<WaitingSwapWidget> {
  @override
  List<Swap> _listSwaps = [];
  String to_message = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      SwapProvider swapProvider = context.read<SwapProvider>();
      swapProvider.fetchWaitingSwap();
      _listSwaps = swapProvider.getWaitingSwap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final swapProvider = context.watch<SwapProvider>();

    return BpScaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
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
                    "Waiting Book Swap",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            //Search Filed
            const SizedBox(height: 20),
            // If _listSwaps is empty, show no data
            if (_listSwaps.isEmpty)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Waiting Swap Data"),
                ],
              )
            else // If _listSwaps is not empty, show the data
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                                "From: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_listSwaps[index].fields.fromUser),
                            ],
                          ),
                        ),
                        // Delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                            TextButton(
                              onPressed: () {
                                // Show TextBox Dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Accept Book Swap Request"),
                                      content: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            to_message = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Message",
                                        ),
                                      ),
                                      actions: [
                                        // Cancel Button
                                        TextButton(
                                          onPressed: () {
                                            to_message = "";
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (to_message == "") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pesan tidak boleh kosong"),
                                                ),
                                              );
                                              return;
                                            } else {
                                              swapProvider
                                                  .swapAccept(
                                                      _listSwaps[index]
                                                          .pk
                                                          .toString(),
                                                      to_message)
                                                  .whenComplete(() {
                                                setState(() {
                                                  _listSwaps.removeAt(index);
                                                });
                                              }).whenComplete(() {
                                                setState(() {
                                                  swapProvider.logIn();
                                                });
                                              });
                                              Navigator.pop(context);
                                            }
                                            // Accept Swap
                                            //Navigator.pop(context);
                                          },
                                          child: const Text("Terima"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("Terima"),
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
