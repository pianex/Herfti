import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> readClient(String email) {
  return FirebaseFirestore.instance.collection("Clients").doc(email).get();
}

Stream<QuerySnapshot<Map<String, dynamic>>> readClients() {
  return FirebaseFirestore.instance
      .collection("Clients")
      .orderBy("timeAdded")
      .snapshots();
}
