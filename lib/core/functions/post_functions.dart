import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_a/core/models/post_model.dart';

Stream<List<PostModel>> readPosts() {
  return FirebaseFirestore.instance
      .collection("Posts")
      .orderBy("timeAdded", descending: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList(),
      );
}

Stream<PostModel> readPost(String postUid) {
  return FirebaseFirestore.instance
      .collection("Posts")
      .where("uid", isEqualTo: postUid)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).first,
      );
}
