class CommentModel {
  final String uid;
  final String timeAdded;
  final String postUid;
  final String userUid;
  final String userName;
  final String profType;
  final String userImagePath;
  final String text;

  CommentModel({
    required this.uid,
    required this.timeAdded,
    required this.postUid,
    required this.profType,
    required this.text,
    required this.userUid,
    required this.userName,
    required this.userImagePath,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "timeAdded": timeAdded,
    "postUid": postUid,
    "userUid": userUid,
    "userName": userName,
    "userImagePath": userImagePath,
    "text": text,
    "profType": profType,
  };

  static CommentModel fromJson(Map<String, dynamic> json) => CommentModel(
    uid: json["uid"],
    timeAdded: json["timeAdded"],
    postUid: json["postUid"],
    userUid: json["userUid"],
    userName: json["userName"],
    userImagePath: json["userImagePath"],
    text: json["text"],
    profType: json["profType"],
  );
}
