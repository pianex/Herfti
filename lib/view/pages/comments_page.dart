import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/core/functions/post_functions.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';
import 'package:project_a/core/models/comment_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_profile.dart';
import 'package:project_a/view/widgets/comment.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
    required this.postUid,
    required this.userUid,
    required this.imagePath,
    required this.userImagePath,
    required this.name,
    required this.text,
    required this.type,
    required this.time,
    required this.likes,
    required this.isLiked,
    required this.likersUids,
    required this.comments,
    required this.firstTag,
    required this.secondTag,
  });
  final String postUid;
  final String userUid;
  final String userImagePath;
  final String imagePath;
  final String name;
  final String type;
  final String time;
  final String text;
  final int likes;
  final bool isLiked;
  final List<dynamic> likersUids;
  final int comments;
  final String firstTag;
  final String secondTag;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  bool isLiked = false;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> likedPosts = sharedPref.getStringList("likedPosts") ?? [];
    String userName = sharedPref.getString("name")!;
    String imagePath =
        sharedPref.getString("imagePath") ??
        sharedPref.getString("googleImagePath") ??
        "";
    String email = sharedPref.getString("email")!;

    if (likedPosts.contains(widget.postUid)) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    Image asset = Image.asset(widget.imagePath, fit: BoxFit.cover);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "التعليقات",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              children: [
                SizedBox(height: 10),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
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
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                widget.type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 1,
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
                widget.imagePath.isNotEmpty
                    ? Hero(
                        tag: "tag2",
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          height: asset.height,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.network(
                            widget.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc(widget.postUid)
                      .snapshots(),
                  builder: (context, asyncSnapshot) {
                    // int currentLikes =
                    //     asyncSnapshot.data?.data()?["likesCount"] ??

                    int currentComments =
                        asyncSnapshot.data?.data()?["commentsCount"] ??
                        widget.comments;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),

                        LikeButton(
                          countPostion: CountPostion.left,
                          countDecoration: (counter, likeCount) {
                            return Text(
                              shrinkLikesFormula(
                                asyncSnapshot.data?.data()?["likesCount"] ??
                                    widget.likes,
                              ),
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 21,
                              ),
                            );
                          },
                          isLiked:
                              asyncSnapshot.data
                                  ?.data()?["likersUids"]
                                  .contains(email) ??
                              widget.likersUids.contains(email),
                          likeCount: widget.likes,
                          likeBuilder: (isLiked) {
                            return Icon(
                              isLiked ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 30,
                            );
                          },
                          // ignore: body_might_complete_normally_nullable
                          onTap: (isLiked) async {
                            List<dynamic> likersUids =
                                asyncSnapshot.data?.data()?["likersUids"] ??
                                widget.likersUids;
                            if (isLiked) {
                              likersUids.remove(email);
                              likedPosts.remove(widget.postUid);
                              sharedPref.setStringList(
                                "likedPosts",
                                likedPosts,
                              );
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(widget.postUid)
                                  .update({
                                    "likersUids": likersUids,
                                    "likesCount": likersUids.length,
                                  })
                                  .whenComplete(() {
                                    setState(() {});
                                  });
                            } else {
                              likedPosts.add(widget.postUid);
                              sharedPref.setStringList(
                                "likedPosts",
                                likedPosts,
                              );
                              likersUids.add(email);
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(widget.postUid)
                                  .update({
                                    "likersUids": likersUids,
                                    "likesCount": likersUids.length,
                                  })
                                  .whenComplete(() {
                                    setState(() {});
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
                          shrinkLikesFormula(currentComments),
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 21,
                          ),
                        ),
                        Icon(Icons.message, color: Colors.blue[300], size: 30),
                        Spacer(),
                        Text(
                          widget.time,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Spacer(),
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: readPost(widget.postUid),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('حدث خطأ ما! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final comments = snapshot.data!.comments;
                      // print(comments);
                      if (comments.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              "لا توجد تعليقات بعد. كن أول من يعلق!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: () async {
                                List comments = await FirebaseFirestore.instance
                                    .collection("Posts")
                                    .doc(widget.postUid)
                                    .get()
                                    .then((doc) {
                                      return doc.data()!["comments"] ?? [];
                                    });
                                comments.removeAt(index);
                                FirebaseFirestore.instance
                                    .collection("Posts")
                                    .doc(widget.postUid)
                                    .update({
                                      "comments": comments,
                                      "commentsCount": comments.length,
                                    })
                                    .whenComplete(() {
                                      setState(() {});
                                    });
                              },
                              child: Comment(
                                text: comments[index]["text"],
                                postUid: widget.postUid,
                                index: index,
                                uid: comments[index]["uid"],
                                timeAdded: comments[index]["timeAdded"],
                                userUid: comments[index]["userUid"],
                                userName: comments[index]["userName"],
                                profType: comments[index]["profType"],
                                userImagePath: comments[index]["userImagePath"],
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: 100),
              ],
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: backgroundColor,
                // border: Border(top: BorderSide(color: Colors.grey)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CustTextFormField(
                label: "أكتب تعليقا...",
                controller: commentController,
                suffix: GestureDetector(
                  onDoubleTap: () {},
                  onTap: () async {
                    showProgressDialog(
                      context,
                      Size(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.width / 2,
                      ),
                    );
                    List comments = await FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.postUid)
                        .get()
                        .then((doc) {
                          return doc.data()!["comments"] ?? [];
                        });
                    final json = CommentModel(
                      uid: DateTime.now().microsecondsSinceEpoch.toString(),
                      timeAdded: DateTime.now().toString(),
                      postUid: widget.postUid,
                      userUid: widget.userUid,
                      userName: userName,
                      profType: "النوع",
                      userImagePath: imagePath,
                      text: commentController.text,
                    ).toJson();
                    comments.add(json);
                    FirebaseFirestore.instance
                        .collection("Posts")
                        .doc(widget.postUid)
                        .update({
                          "comments": comments,
                          "commentsCount": comments.length,
                        })
                        .then((value) {
                          // Navigator.pop(context);
                          commentController.clear();
                          Navigator.pop(context);
                        });
                  },
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
