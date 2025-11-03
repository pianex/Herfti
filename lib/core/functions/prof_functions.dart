import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> readProf(String email) {
  return FirebaseFirestore.instance.collection("Profs").doc(email).get();
}
