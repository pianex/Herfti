import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_a/core/models/comment_model.dart';

Stream<List<CommentModel>> readComments(String postUid) {
  return FirebaseFirestore.instance
      .collection("Posts")
      .where("postUid", isEqualTo: postUid)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromJson(doc.data()["comments"]))
            .toList(),
      );
}
