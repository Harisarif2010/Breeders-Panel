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
          herdId: herdId,
          scoringEntry: data['scoringEntry'] ?? '',
          name: data['name'] ?? '',
          dob: data['dob'] ?? '',
          sire: data['sire'] ?? '',
          dam: data['dam'] ?? '',
          finalScore: int.tryParse(data['finalScore']?.toString() ?? '0') ?? 0,
          timeOfCalved: data['timeOfCalved'] ?? '',
          cowid: data['cowid'] ?? '',
          quiz1Details: data['quiz1Detail'] ?? {},
          quiz1Score: data['quiz1Score'] ?? '0',
          quiz2Details: data['quiz2Details'] ?? {},
          quiz2Score: data['quiz2Score'] ?? '0',
          quiz3Details: data['quiz3Details'] ?? {},
          quiz3Score: data['quiz3Score'] ?? '0',
          quiz4Details: data['quiz4Details'] ?? {},
          quiz4Score: data['quiz4Score'] ?? '0',
          quiz5Details: data['quiz5Details'] ?? {},
          quiz5Score: data['quiz5Score'] ?? '0',
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
  final String herdId;
  final String name;
  final String cowid;
  final String dob;
  final String sire;
  final String dam;
  final int finalScore;
  final String timeOfCalved;
  final Map<String, dynamic> quiz1Details;
  final String quiz1Score;
  final Map<String, dynamic> quiz2Details;
  final String quiz2Score;
  final Map<String, dynamic> quiz3Details;
  final String quiz3Score;
  final Map<String, dynamic> quiz4Details;
  final String quiz4Score;
  final Map<String, dynamic> quiz5Details;
  final String quiz5Score;

  ScoringEntry({
    required this.scoringEntry,
    required this.herdId,
    required this.name,
    required this.dob,
    required this.sire,
    required this.dam,
    required this.finalScore,
    required this.timeOfCalved,
    required this.cowid,
    required this.quiz1Details,
    required this.quiz1Score,
    required this.quiz2Details,
    required this.quiz2Score,
    required this.quiz3Details,
    required this.quiz3Score,
    required this.quiz4Details,
    required this.quiz4Score,
    required this.quiz5Details,
    required this.quiz5Score,
  });

  Map<String, dynamic> toMap() {
    return {
      'herdId': herdId, 
      'cowid': cowid,
      'name': name,
      'dob': dob,
      'sire': sire,
      'dam': dam,
      'finalScore': finalScore,
      'timeOfCalved': timeOfCalved,
      'quiz1Details': quiz1Details,
      'quiz1Score': quiz1Score,
      'quiz2Details': quiz2Details,
      'quiz2Score': quiz2Score,
      'quiz3Details': quiz3Details,
      'quiz3Score': quiz3Score,
      'quiz4Details': quiz4Details,
      'quiz4Score': quiz4Score,
      'quiz5Details': quiz5Details,
      'quiz5Score': quiz5Score,
    };
  }
}
