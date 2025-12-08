class PostModel {
  final String uid;
  final String timeAdded;
  final String profUid;

  final String text;
  final List<String> imagePaths;
  final int likesCount;
  final int commentsCount;
  PostModel({
    required this.uid,
    required this.timeAdded,
    required this.profUid,

    required this.text,
    required this.imagePaths,
    required this.likesCount,
    required this.commentsCount,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "timeAdded": timeAdded,
    "profUid": profUid,

    "text": text,
    "imagePths": imagePaths,
    "likesCount": likesCount,
    "commentsCount": commentsCount,
  };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
    uid: json["uid"],
    timeAdded: json["timeAdded"],
    profUid: json["profUid"],

    text: json["text"],
    imagePaths: json["imagePaths"],
    likesCount: json["likesCount"],
    commentsCount: json["commentsCount"],
  );
}
