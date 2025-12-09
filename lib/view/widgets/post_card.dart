import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/view/pages/comments_page.dart';
import 'package:project_a/view/pages/prof_profile.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.name,
    required this.type,
    required this.time,
    required this.imagePath,
    required this.text,
    required this.likes,
    required this.firstTag,
    required this.secondTag,
  });
  final String name;
  final String type;
  final String time;
  final String imagePath;
  final String text;
  final int likes;
  final String firstTag;
  final String secondTag;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  void toggleLike() {
    setState(() {
      isLiked == false ? likes++ : likes--;
      isLiked = !isLiked;
    });
  }

  int likes = 162;

  @override
  Widget build(BuildContext context) {
    Image asset = Image.asset(widget.imagePath, fit: BoxFit.cover);
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
                      ProfessionalProfile(tag: widget.firstTag),
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
                          tag: widget.firstTag,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue[900],
                            backgroundImage: NetworkImage(widget.imagePath),
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
                          child: Image.network(
                            widget.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).animate().untint(duration: Duration(milliseconds: 350)),
                    ),
                  );
                },
                child: Hero(
                  tag: widget.secondTag,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: asset.height,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(widget.imagePath, fit: BoxFit.cover),
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
                shrinkLikesFormula(likes),
                style: TextStyle(color: Colors.amber, fontSize: 21),
              ),
              GestureDetector(
                onDoubleTap: () {},
                onTap: () {
                  toggleLike();
                },
                child: Icon(
                  isLiked ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
              SizedBox(width: 40),
              Text(
                shrinkLikesFormula(73),
                style: TextStyle(color: Colors.blue[300], fontSize: 21),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CommentsPage(
                        imagePath: widget.secondTag,
                        name: widget.name,
                        text: widget.text,
                        type: widget.type,
                        time: widget.time,
                        likes: likes,
                        firstTag: widget.firstTag,
                        secondTag: widget.secondTag,
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
