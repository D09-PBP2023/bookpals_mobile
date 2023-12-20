import 'package:flutter/material.dart';

import '../../../core/environments/endpoints.dart';
import '../../../services/api.dart';
import '../../../features/request/models/request.dart';

class GetRequestProvider with ChangeNotifier {
  List<Request> listRequest = [];

  Future<void> fetchRequest(int pk) async {
    final response = await APIHelper.get(Endpoints.getRequest);
    listRequest = [];
    for (var item in response) {
      if (item != null) {
        listRequest.add(Request.fromJson(item));
      }
    }
    notifyListeners();
  }
}