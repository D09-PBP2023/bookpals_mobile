import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/search_field.dart';
import '../../main/screens/home_page.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../screens/book_swap.dart';

class WaitingSwapWidget extends StatefulWidget {
  //Override Key
  const WaitingSwapWidget({super.key});

  @override
  State<WaitingSwapWidget> createState() => _WaitingSwapWidgetState();
}

class _WaitingSwapWidgetState extends State<WaitingSwapWidget> {
  @override
  List<Swap> _listSwaps = [];
  String _searchController = "";
  String to_message = "";

  void initState() {
    super.initState();
    SwapProvider swapProvider = context.read<SwapProvider>();
    swapProvider.fetchWaitingSwap();
    _listSwaps = swapProvider.getWaitingSwap();
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
                const Text("Permintaan Tukar Buku"),
              ],
            ),
            //Search Filed
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  _searchController = value;
                });
              },
            ),
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
                          title: Text(_listSwaps[index].fields.wantBook),
                          subtitle: Text(_listSwaps[index].fields.haveBook),
                          trailing: Text(_listSwaps[index].fields.fromUser),
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
                                              Navigator.pop(context);
                                            }).whenComplete(() {
                                              setState(() {});
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
