class PostModel {
  final String uid;
  final String timeAdded;
  final String profUid;
  final String profName;
  final String profImagePath;
  final String text;
  final String image;
  final int likesCount;
  final int commentsCount;
  PostModel({
    required this.uid,
    required this.timeAdded,
    required this.profUid,
    required this.profName,
    required this.profImagePath,
    required this.text,
    required this.image,
    required this.likesCount,
    required this.commentsCount,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "timeAdded": timeAdded,
    "profUid": profUid,
    "profName": profName,
    "profImagePath": profImagePath,
    "text": text,
    "image": image,
    "likesCount": likesCount,
    "commentsCount": commentsCount,
  };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
    uid: json["uid"],
    timeAdded: json["timeAdded"],
    profUid: json["profUid"],
    profName: json["profName"],
    profImagePath: json["profImagePath"],
    text: json["text"],
    image: json["image"],
    likesCount: json["likesCount"],
    commentsCount: json["commentsCount"],
  );
}
