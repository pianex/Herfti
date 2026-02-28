import 'package:cloud_firestore/cloud_firestore.dart';

Future deleteComment(String postUid, commentUid) async {
  var data = await FirebaseFirestore.instance
      .collection("Posts")
      .doc(postUid)
      .get();
  Map<String, dynamic> comments = data.data()!["comments"];
  comments.removeWhere((key, value) => key == commentUid);
  await FirebaseFirestore.instance.collection("Posts").doc(postUid).update({
    "comments": comments,
  });
}
