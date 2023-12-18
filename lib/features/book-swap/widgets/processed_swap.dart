import 'package:flutter/material.dart';

import '../../../core/bases/widgets/search_field.dart';
import '../providers/swap_provider.dart';
import 'package:provider/provider.dart';
import '../models/swap.dart';

class ProcessedSwap extends StatefulWidget {
  const ProcessedSwap({super.key});

  @override
  State<ProcessedSwap> createState() => _ProcessedSwapState();
}

class _ProcessedSwapState extends State<ProcessedSwap> {
  @override
  void initState() {
    super.initState();

    /*List<Swap> _listSwaps = <Swap>[];
    Swap? first;
    SwapProvider swapProvider = context.read<SwapProvider>();
    setState(() {
      _listSwaps = swapProvider.getProcessedSwap();
      first = _listSwaps.first;
    });*/
  }

  String _searchTextController = "";
  @override
  Widget build(BuildContext context) {
    final swapProvider = context.watch<SwapProvider>();
    return Column(
      children: [
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
              _searchTextController = value;
            });
          },
        ),
        SizedBox(height: 20),
        //List of Swa
      ],
    );
  }
}
