// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeService {
//  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Fetch requests with status 'pending'
//   Stream<List<Map<String, dynamic>>> fetchPendingRequests() {
//     return _firestore
//         .collection('new_requests')
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .map(
//       (snapshot) {
//         return snapshot.docs.map((doc) {
//           return {
//             'id': doc.id,
//             ...doc.data() as Map<String, dynamic>,
//           };
//         }).toList();
//       },
//     );
//   }

//   // Update request status
//   Future<void> updateRequestStatus(String id, String status) async {
//     await _firestore.collection('new_requests').doc(id).update({'status': status});
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch herds
  Future<List<Map<String, dynamic>>> fetchHerds() async {
    final snapshot = await _firestore.collection('herds').get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

  // Fetch requests with status 'pending'
  Stream<List<Map<String, dynamic>>> fetchPendingRequests() {
    return _firestore
        .collection('new_requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      },
    );
  }

  // Update request status
  Future<void> updateRequestStatus(String id, String status) async {
    await _firestore.collection('new_requests').doc(id).update({'status': status});
  }
}
