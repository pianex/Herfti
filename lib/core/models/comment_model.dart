class CommentModel {
  final String uid;
  final String timeAdded;
  final String postUid;
  final String profUid;
  final String profName;
  final String profType;
  final String profImagePath;
  final String text;

  CommentModel({
    required this.uid,
    required this.timeAdded,
    required this.postUid,
    required this.profUid,
    required this.profName,
    required this.profType,
    required this.profImagePath,
    required this.text,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "timeAdded": timeAdded,
    "commentUid": postUid,
    "profUid": profUid,
    "profName": profName,
    "profType": profType,
    "profImagePath": profImagePath,
    "text": text,
  };

  static CommentModel fromJson(Map<String, dynamic> json) => CommentModel(
    uid: json["uid"],
    timeAdded: json["timeAdded"],
    postUid: json["postUid"],
    profUid: json["profUid"],
    profName: json["profName"],
    profType: json["profType"],
    profImagePath: json["profImagePath"],
    text: json["text"],
  );
}
