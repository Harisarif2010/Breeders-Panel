// import 'package:flutter/material.dart';
// import 'package:flutter_application_breedersweb/services/home_services.dart';

// class HomeProvider with ChangeNotifier {
//   final HomeService _service = HomeService();

//   // Stream of pending requests
//   Stream<List<Map<String, dynamic>>> get pendingRequestsStream =>
//       _service.fetchPendingRequests();

//   // Update request status
//   Future<void> updateStatus(String id, String status) async {
//     await _service.updateRequestStatus(id, status);
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/services/home_services.dart';

class HomeProvider with ChangeNotifier {
  final HomeService _service = HomeService();

  List<Map<String, dynamic>> _herds = [];
  List<Map<String, dynamic>> get herds => _herds;

  Future<void> fetchHerds() async {
    _herds = await _service.fetchHerds();
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> get pendingRequestsStream =>
      _service.fetchPendingRequests();

  Future<void> updateStatus(String id, String status) async {
    await _service.updateRequestStatus(id, status);
  }
}
