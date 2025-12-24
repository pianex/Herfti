import 'package:project_a/core/models/comment_model.dart';

class PostModel {
  final String uid;
  final String timeAdded;
  final String profUid;
  final String profName;
  final String profType;
  final String profImagePath;
  final String text;
  final List<dynamic> imagePaths;
  final List<dynamic> comments;
  final int likesCount;
  final int commentsCount;
  PostModel({
    required this.uid,
    required this.timeAdded,
    required this.profUid,
    required this.profName,
    required this.profType,
    required this.profImagePath,
    required this.text,
    required this.imagePaths,
    required this.comments,
    required this.likesCount,
    required this.commentsCount,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "timeAdded": timeAdded,
    "profUid": profUid,
    "profName": profName,
    "profType": profType,
    "profImagePath": profImagePath,
    "text": text,
    "imagePaths": imagePaths,
    "comments": comments,
    "likesCount": likesCount,
    "commentsCount": commentsCount,
  };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
    uid: json["uid"],
    timeAdded: json["timeAdded"],
    profUid: json["profUid"],
    profName: json["profName"],
    profType: json["profType"],
    profImagePath: json["profImagePath"],
    text: json["text"],
    imagePaths: json["imagePaths"],
    comments: json["comments"] ?? [],
    likesCount: json["likesCount"],
    commentsCount: json["commentsCount"],
  );
}
