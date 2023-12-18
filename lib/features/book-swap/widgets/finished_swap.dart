import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/search_field.dart';
import '../../main/screens/home_page.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';
import '../screens/book_swap.dart';

class FinishedSwapWidget extends StatefulWidget {
  //Override Key
  const FinishedSwapWidget({super.key});

  @override
  State<FinishedSwapWidget> createState() => _FinishedSwapWidgetState();
}

class _FinishedSwapWidgetState extends State<FinishedSwapWidget> {
  @override
  List<Swap> _listSwaps = [];
  String _searchController = "";

  void initState() {
    super.initState();
    SwapProvider swapProvider = context.read<SwapProvider>();
    swapProvider.fetchFinishedSwap();
    _listSwaps = swapProvider.getFinishedSwap();
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
                  const Text("Tidak ada buku yang diterima"),
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
                        // Finished Text
                        const Text("Finished"),
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
