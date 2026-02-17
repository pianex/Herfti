import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:like_button/like_button.dart';
import 'package:popover/popover.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/comments_page.dart';
import 'package:project_a/view/pages/prof_profile.dart';
import 'package:project_a/view/widgets/post_menu.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.uid,
    required this.userUid,
    required this.name,
    required this.type,
    required this.userImagePath,
    required this.time,
    required this.imagePath,
    required this.imagePaths,
    required this.text,
    required this.likes,
    required this.isLiked,
    required this.comments,
    required this.likersUids,
    required this.firstTag,
    required this.secondTag,
  });
  final String uid;
  final String userUid;
  final String name;
  final String type;
  final String userImagePath;
  final String time;
  final String? imagePath;
  final List<dynamic> imagePaths;
  final String text;
  final int likes;
  final bool isLiked;
  final int comments;
  final List<dynamic> likersUids;
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
  int image = 0;
  @override
  Widget build(BuildContext context) {
    // Image? asset = Image.asset(widget.imagePath ?? "", fit: BoxFit.cover);
    List<String> likedPosts = sharedPref.getStringList("likedPosts") ?? [];
    String email = sharedPref.getString("email")!;
    if (likedPosts.contains(widget.uid)) {
      isLiked = true;
    } else {
      isLiked = false;
    }
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
                  builder: (context) => ProfessionalProfile(
                    tag: widget.userImagePath,
                    profUid: widget.userUid,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.userImagePath,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[900],
                      backgroundImage: NetworkImage(widget.userImagePath),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.type,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showPopover(
                        context: context,
                        bodyBuilder: (context) => PostMenu(),
                        width: 250,
                        height: 150,
                        backgroundColor: Colors.red[700]!,
                        radius: 20,
                        arrowHeight: 20,
                        arrowWidth: 30,
                      );
                    },
                    icon: Icon(Icons.more_horiz, color: Colors.white, size: 25),
                  ),
                ],
              ),
            ),
          ),
          widget.text.length < 70
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CommentsPage(
                          postUid: widget.uid,
                          userUid: widget.userUid,
                          userImagePath: widget.userImagePath,
                          imagePath: widget.imagePath ?? "tag2",
                          name: widget.name,
                          text: widget.text,
                          type: widget.type,
                          time: widget.time,
                          likes: widget.likes,
                          comments: widget.comments,
                          firstTag: widget.userImagePath,
                          secondTag: widget.imagePath ?? "tag2",
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CommentsPage(
                          postUid: widget.uid,
                          userUid: widget.userUid,
                          userImagePath: widget.userImagePath,
                          imagePath: widget.imagePath ?? "tag2",
                          name: widget.name,
                          text: widget.text,
                          type: widget.type,
                          time: widget.time,
                          likes: widget.likes,
                          comments: widget.comments,
                          firstTag: widget.userImagePath,
                          secondTag: widget.imagePath ?? "tag2",
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Text(
                          widget.text,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Color(0xFF11152E)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Icon(Icons.expand_more, color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                ),
          widget.imagePaths.isNotEmpty
              ? Container(
                  constraints: BoxConstraints(maxHeight: 300),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imagePaths.length,

                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        image = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child:
                                  Dialog(
                                    shadowColor: Colors.black,
                                    child: Container(
                                      width: double.infinity,
                                      // height: asset.height,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.white,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          width: 5,
                                        ),
                                      ),
                                      child: widget.imagePaths.isNotEmpty
                                          ? Image.network(
                                              widget.imagePaths[index] ?? "",
                                              fit: BoxFit.cover,
                                            )
                                          : Container(),
                                    ),
                                  ).animate().untint(
                                    duration: Duration(milliseconds: 350),
                                  ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: widget.imagePath ?? "tag2",
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            // height: asset.height,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFF11152E),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: widget.imagePaths.isNotEmpty
                                ? Image.network(
                                    widget.imagePaths[index] ?? "",
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null &&
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                              ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                              : null,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length < 5 ? widget.imagePaths.length : 5,
              (index) => Container(
                margin: const EdgeInsets.all(8),
                height: image == index ? 8 : 7,
                width: image == index ? 8 : 7,
                decoration: BoxDecoration(
                  color: image == index ? Colors.white : Colors.grey[800],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Text(
              //   shrinkLikesFormula(widget.likes),
              //   style: TextStyle(color: Colors.amber, fontSize: 21),
              // ),
              // GestureDetector(
              //   onDoubleTap: () {},
              //   onTap: () {
              //     if (likedPosts.contains(widget.uid)) {
              //       likedPosts.remove(widget.uid);
              //       sharedPref.setStringList("likedPosts", likedPosts);
              //       int likes = widget.likes - 1;
              //       FirebaseFirestore.instance
              //           .collection("Posts")
              //           .doc(widget.uid)
              //           .update({"likesCount": likes});
              //       setState(() {
              //         isLiked = false;
              //       });
              //     } else {
              //       likedPosts.add(widget.uid);
              //       sharedPref.setStringList("likedPosts", likedPosts);
              //       int likes = widget.likes + 1;
              //       FirebaseFirestore.instance
              //           .collection("Posts")
              //           .doc(widget.uid)
              //           .update({"likesCount": likes});
              //       setState(() {
              //         isLiked = true;
              //       });
              //     }
              //   },
              //   child: Icon(
              //     isLiked ? Icons.star : Icons.star_border,
              //     color: Colors.amber,
              //     size: 30,
              //   ),
              // ),
              LikeButton(
                countPostion: CountPostion.left,
                countDecoration: (counter, likeCount) {
                  return Text(
                    shrinkLikesFormula(widget.likes),
                    style: TextStyle(color: Colors.amber, fontSize: 21),
                  );
                },
                isLiked: widget.isLiked,
                likeCount: widget.likes,
                likeBuilder: (isLiked) {
                  return Icon(
                    isLiked ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  );
                },
                onTap: (isLiked) async {
                  List<dynamic> likersUids = widget.likersUids;
                  if (isLiked) {
                    likersUids.remove(email);
                    likedPosts.remove(widget.uid);
                    sharedPref.setStringList("likedPosts", likedPosts);
                    FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.uid)
                        .update({
                          "likersUids": likersUids,
                          "likesCount": likersUids.length,
                        });
                  } else {
                    likedPosts.add(widget.uid);
                    sharedPref.setStringList("likedPosts", likedPosts);
                    likersUids.add(email);
                    FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.uid)
                        .update({
                          "likersUids": likersUids,
                          "likesCount": likersUids.length,
                        });
                  }
                  // if (likedPosts.contains(widget.uid)) {
                  //   likedPosts.remove(widget.uid);
                  //   sharedPref.setStringList("likedPosts", likedPosts);
                  //   int likes = widget.likes - 1;
                  //   FirebaseFirestore.instance
                  //       .collection("Posts")
                  //       .doc(widget.uid)
                  //       .update({"likesCount": likes});
                  //   // setState(() {
                  //   //   this.isLiked = false;
                  //   // });
                  // } else {
                  //   likedPosts.add(widget.uid);
                  //   sharedPref.setStringList("likedPosts", likedPosts);
                  //   int likes = widget.likes + 1;
                  //   FirebaseFirestore.instance
                  //       .collection("Posts")
                  //       .doc(widget.uid)
                  //       .update({"likesCount": likes});
                  //   // setState(() {
                  //   //   this.isLiked = true;
                  //   // });
                  // }
                  // return !isLiked;
                },
              ),
              SizedBox(width: 40),
              Text(
                shrinkLikesFormula(widget.comments),
                style: TextStyle(color: Colors.blue[300], fontSize: 21),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CommentsPage(
                        postUid: widget.uid,
                        userUid: widget.userUid,
                        userImagePath: widget.userImagePath,
                        imagePath: widget.imagePath ?? "tag2",
                        name: widget.name,
                        text: widget.text,
                        type: widget.type,
                        time: widget.time,
                        likes: widget.likes,
                        comments: widget.comments,
                        firstTag: widget.userImagePath,
                        secondTag: widget.imagePath ?? "tag2",
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.message, color: Colors.blue[300], size: 30),
              ),
              Spacer(),
              Text(
                widget.time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
