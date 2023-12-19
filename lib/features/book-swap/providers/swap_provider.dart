import 'package:http/http.dart';

import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';
import '../../book-swap/models/swap.dart';

class SwapProvider with ChangeNotifier {
  List<Swap> _listSwaps = [];
  List<Swap> _listProcessedSwaps = [];
  List<Swap> _listWaitingSwaps = [];
  List<Swap> _listAcceptedSwaps = [];
  List<Swap> _listFinishedSwaps = [];

  // Parse JsON from Endpoinst.getProcessedSwap
  Future<void> fetchProcessedSwap() async {
    final response = await APIHelper.get(Endpoints.getProcessedSwap);
    _listProcessedSwaps = [];
    for (var item in response) {
      _listProcessedSwaps.add(Swap.fromJson(item));
    }
    notifyListeners();
  }

  // Fetch JSON From Endpoints.getWaitingSwap
  Future<void> fetchWaitingSwap() async {
    final response = await APIHelper.get(Endpoints.getWaitingSwap);
    _listWaitingSwaps = [];
    for (var item in response) {
      _listWaitingSwaps.add(Swap.fromJson(item));
    }
    notifyListeners();
  }

  // Fetch JSON From Endpoints.getAcceptedSwap
  Future<void> fetchAcceptedSwap() async {
    final response = await APIHelper.get(Endpoints.getAcceptedSwap);
    _listAcceptedSwaps = [];
    for (var item in response) {
      _listAcceptedSwaps.add(Swap.fromJson(item));
    }
    notifyListeners();
  }

  // Fetch JSON From Endpoints.getFinishedSwap
  Future<void> fetchFinishedSwap() async {
    final response = await APIHelper.get(Endpoints.getFinishedSwap);
    _listFinishedSwaps = [];
    for (var item in response) {
      _listFinishedSwaps.add(Swap.fromJson(item));
    }
    notifyListeners();
  }

  Future<dynamic> swapRequest(
      String bookId, String bookId2, String message) async {
    return await APIHelper.post(Endpoints.requestSwap, {
      'bookid': bookId2,
      'bookid2': bookId,
      'message': message,
    });
  }

  Future<dynamic> swapAccept(String swapId, String pesan) async {
    return await APIHelper.post(Endpoints.acceptSwap, {
      'id': swapId,
      'message': pesan,
    });
  }

  Future<dynamic> swapFinished(String swapId) async {
    return await APIHelper.post(Endpoints.finishedSwap, {
      'id': swapId,
    });
  }

  Future<dynamic> swapCancel(String swapId) async {
    return await APIHelper.post(Endpoints.cancelSwap, {
      'id': swapId,
    });
  }

  List<Swap> getProcessedSwapByKey(String search) {
    List<Swap> _listProcessedSwaps = [];
    for (var item in _listSwaps) {
      if (item.fields.wantBook.toLowerCase().contains(search.toLowerCase()) ||
          item.fields.wantBook.toLowerCase().contains(search.toLowerCase())) {
        _listProcessedSwaps.add(item);
      }
    }
    return _listProcessedSwaps;
  }

  List<Swap> getProcessedSwap() {
    return _listProcessedSwaps;
  }

  List<Swap> getWaitingSwap() {
    return _listWaitingSwaps;
  }

  List<Swap> getAcceptedSwap() {
    return _listAcceptedSwaps;
  }

  List<Swap> getFinishedSwap() {
    return _listFinishedSwaps;
  }

  void logOut() {
    // Clear all list
    _listProcessedSwaps = [];
    _listWaitingSwaps = [];
    _listAcceptedSwaps = [];
    _listFinishedSwaps = [];
    notifyListeners();
  }

  void logIn() {
    fetchProcessedSwap();
    fetchWaitingSwap();
    fetchAcceptedSwap();
    fetchFinishedSwap();
  }
}
