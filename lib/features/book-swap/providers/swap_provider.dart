import 'dart:convert';

import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';
import '../../book-swap/models/swap.dart';

class SwapProvider with ChangeNotifier {
  bool get signedIn => APIHelper.isSignedIn();
  List<Swap> _listSwaps = [];

  Future<void> fetchProcessedSwap() async {
    final response = await APIHelper.get(Endpoints.getProcessedSwap);
    _listSwaps = [];
    for (var item in response) {
      _listSwaps.add(Swap.fromJson(item));
    }
    notifyListeners();
  }

  Future<dynamic> swapRequest(
      String bookId, String bookId2, String message) async {
    return await APIHelper.post(Endpoints.requestSwap, {
      'bookid': bookId,
      'bookid2': bookId2,
      'message': message,
    });
  }

  Future<dynamic> swapAccept(String swapId) async {
    return await APIHelper.post(Endpoints.acceptSwap, {
      'swapid': swapId,
    });
  }

  Future<dynamic> swapComplete(String swapId) async {
    return await APIHelper.post(Endpoints.completeSwap, {
      'swapid': swapId,
    });
  }

  Future<dynamic> swapCancel(String swapId) async {
    return await APIHelper.post(Endpoints.cancelSwap, {
      'swapid': swapId,
    });
  }

  List<Swap> getProcessedSwap() {
    return _listSwaps;
  }
}
