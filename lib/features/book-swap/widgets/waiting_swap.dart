import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';

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
                  const Text("Tidak ada Buku Yang Diminta"),
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
                            TextButton(
                              onPressed: () {
                                // Message Box to Send Message
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Kirim Pesan"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Pesan',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            to_message = value;
                                          });
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
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
                                                swapProvider.fetchWaitingSwap();
                                              });
                                            });
                                          },
                                          child: const Text("Kirim"),
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
