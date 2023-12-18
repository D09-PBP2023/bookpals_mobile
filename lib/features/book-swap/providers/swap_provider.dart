import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import 'package:flutter/material.dart';

class SwapProvider with ChangeNotifier {
  Future<dynamic> swapRequest(
      String bookId, String bookId2, String message) async {
    return await APIHelper.post(Endpoints.requestSwap, {
      'ownedbook': bookId,
      'wantedbook': bookId2,
      'message': message,
    });
  }
}
