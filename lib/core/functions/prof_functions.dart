import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> readProf(String email) {
  return FirebaseFirestore.instance.collection("Profs").doc(email).get();
}

Stream<QuerySnapshot<Map<String, dynamic>>> readProfs(int? sellerType) {
  return sellerType == null
      ? FirebaseFirestore.instance
            .collection("Profs")
            .orderBy("saves", descending: true)
            .orderBy("timeAdded")
            .snapshots()
      : FirebaseFirestore.instance
            .collection("Profs")
            .where("type", isEqualTo: sellerType)
            .orderBy("saves", descending: true)
            .orderBy("timeAdded")
            .snapshots();
}
