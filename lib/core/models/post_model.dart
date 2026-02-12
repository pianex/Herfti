class PostModel {
  final String uid;
  final String timeAdded;
  final String userUid;
  final String userName;
  final String profType;
  final String userImagePath;
  final String text;
  final List<dynamic> imagePaths;
  final List<dynamic> comments;
  final int likesCount;
  final int commentsCount;
  final List<String> tokens;
  PostModel({
    required this.uid,
    required this.userUid,
    required this.userName,
    required this.userImagePath,
    required this.timeAdded,
    required this.profType,
    required this.text,
    required this.imagePaths,
    required this.comments,
    required this.likesCount,
    required this.commentsCount,
    required this.tokens,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "userUid": userUid,
    "userName": userName,
    "userImagePath": userImagePath,
    "timeAdded": timeAdded,
    "profType": profType,
    "text": text,
    "imagePaths": imagePaths,
    "comments": comments,
    "likesCount": likesCount,
    "commentsCount": commentsCount,
    "tokens": tokens,
  };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
    uid: json["uid"],
    userUid: json["userUid"],
    userName: json["userName"],
    userImagePath: json["userImagePath"],
    timeAdded: json["timeAdded"],
    profType: json["profType"],
    text: json["text"],
    imagePaths: json["imagePaths"],
    comments: json["comments"] ?? [],
    likesCount: json["likesCount"],
    commentsCount: json["commentsCount"],
    tokens: List<String>.from(json["tokens"] ?? []),
  );
}
