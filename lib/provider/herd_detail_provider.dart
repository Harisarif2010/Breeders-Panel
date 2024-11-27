import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HerdDetailProvider extends ChangeNotifier {
  List<ScoringEntry> _scoringEntries = [];
  bool _isLoading = true;

  List<ScoringEntry> get scoringEntries => _scoringEntries;
  bool get isLoading => _isLoading;

  void fetchScoringEntries(String herdId) async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Cow Scoring')
          .where('herdId', isEqualTo: herdId)
          .get();

      _scoringEntries = snapshot.docs.map((doc) {
        final data = doc.data();
        return ScoringEntry(
          scoringEntry: data['scoringEntry'] ?? '',
          name: data['name'] ?? '',
          dob: data['dob'] ?? '',
          sire: data['sire'] ?? '',
          dam: data['dam'] ?? '',
          finalScore: int.tryParse(data['finalScore']?.toString() ?? '0') ?? 0,
          timeOfCalved: data['timeOfCalved'] ?? '',
          cowid: data['cowid'] ?? '',
        );
      }).toList();
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class ScoringEntry {
  final String scoringEntry;
  final String name;
  final String cowid;
  final String dob;
  final String sire;
  final String dam;
  final int finalScore;
  final String timeOfCalved;

  ScoringEntry({
    required this.scoringEntry,
    required this.name,
    required this.dob,
    required this.sire,
    required this.dam,
    required this.finalScore,
    required this.timeOfCalved,
    required this.cowid,
  });
}
