import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/services/user_herd_services.dart';


class UserHerdProvider with ChangeNotifier {
  final UserHerdService _service = UserHerdService();

  String? _uid; // Store the UID
  List<Map<String, dynamic>> _herds = [];
  List<Map<String, dynamic>> get herds => _herds;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setUid(String uid) {
    _uid = uid;
    fetchHerds();
  }

  Future<void> fetchHerds() async {
    if (_uid == null) return;

    _isLoading = true;
    notifyListeners();

    // Fetch data using the stored UID
    _herds = await _service.fetchHerds(_uid!);

    _isLoading = false;
    notifyListeners();
  }
}
