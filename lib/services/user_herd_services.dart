import 'package:cloud_firestore/cloud_firestore.dart';

class UserHerdService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchHerds(String uid) async {
    final snapshot = await _firestore
        .collection('herds')
        .where('userId', isEqualTo: uid) 
        .get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

 
}

