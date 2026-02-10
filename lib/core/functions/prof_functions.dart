import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> readProf(String email) {
  return FirebaseFirestore.instance.collection("Profs").doc(email).get();
}

Stream<QuerySnapshot<Map<String, dynamic>>> readProfs() {
  return FirebaseFirestore.instance
      .collection("Profs")
      .orderBy("saves", descending: true)
      .orderBy("timeAdded")
      .snapshots();
}
