import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/comments_page.dart';
import 'package:project_a/view/pages/prof_profile.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.uid,
    required this.name,
    required this.type,
    required this.profImagePath,
    required this.time,
    required this.imagePath,
    required this.text,
    required this.likes,
    required this.firstTag,
    required this.secondTag,
  });
  final String uid;
  final String name;
  final String type;
  final String profImagePath;
  final String time;
  final String? imagePath;
  final String text;
  final int likes;
  final String firstTag;
  final String secondTag;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  // void toggleLike() {
  //   setState(() {
  //     isLiked == false ? likes++ : likes--;
  //     isLiked = !isLiked;
  //   });
  // }

  // int likes = 162;

  @override
  Widget build(BuildContext context) {
    Image? asset = Image.asset(widget.imagePath ?? "", fit: BoxFit.cover);
    List<String> likedPosts = sharedPref.getStringList("likedPosts") ?? [];
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      width: double.infinity,
      // height: 140,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color(0xFF11152E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfessionalProfile(tag: widget.profImagePath),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Hero(
                          tag: widget.profImagePath,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue[900],
                            backgroundImage: NetworkImage(widget.profImagePath),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              widget.type,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  Text(
                    widget.time,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Dialog(
                        shadowColor: Colors.black,
                        child: Container(
                          width: double.infinity,
                          height: asset.height,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 5,
                            ),
                          ),
                          child: widget.imagePath!.isNotEmpty
                              ? Image.network(
                                  widget.imagePath ?? "",
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                      ).animate().untint(duration: Duration(milliseconds: 350)),
                    ),
                  );
                },
                child: Hero(
                  tag: widget.imagePath ?? "tag2",
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: asset.height,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: widget.imagePath!.isNotEmpty
                        ? Image.network(
                            widget.imagePath ?? "",
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                height: asset.height,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(0),
                      Colors.black.withAlpha(50),
                      Colors.black.withAlpha(100),
                    ],
                  ),
                  // color: Colors.black.withAlpha(80),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                shrinkLikesFormula(widget.likes),
                style: TextStyle(color: Colors.amber, fontSize: 21),
              ),
              GestureDetector(
                onDoubleTap: () {},
                onTap: () {
                  if (likedPosts.contains(widget.uid)) {
                    likedPosts.remove(widget.uid);
                    sharedPref.setStringList("likedPosts", likedPosts);
                    int likes = widget.likes - 1;
                    FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.uid)
                        .update({"likesCount": likes});
                    setState(() {
                      isLiked = false;
                    });
                  } else {
                    likedPosts.add(widget.uid);
                    sharedPref.setStringList("likedPosts", likedPosts);
                    int likes = widget.likes + 1;
                    FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.uid)
                        .update({"likesCount": likes});
                    setState(() {
                      isLiked = true;
                    });
                  }
                },
                child: Icon(
                  isLiked ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
              SizedBox(width: 40),
              Text(
                shrinkLikesFormula(0),
                style: TextStyle(color: Colors.blue[300], fontSize: 21),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CommentsPage(
                        profImagePath: widget.profImagePath,
                        imagePath: widget.imagePath ?? "tag2",
                        name: widget.name,
                        text: widget.text,
                        type: widget.type,
                        time: widget.time,
                        likes: widget.likes,
                        firstTag: widget.profImagePath,
                        secondTag: widget.imagePath ?? "tag2",
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.message, color: Colors.blue[300], size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
