import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/comment_function.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_profile.dart';
import 'package:project_a/view/widgets/comment.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
    required this.postUid,
    required this.imagePath,
    required this.profImagePath,
    required this.name,
    required this.text,
    required this.type,
    required this.time,
    required this.likes,
    required this.comments,
    required this.firstTag,
    required this.secondTag,
  });
  final String postUid;
  final String profImagePath;
  final String imagePath;
  final String name;
  final String type;
  final String time;
  final String text;
  final int likes;
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfessionalProfile(
                                tag: widget.profImagePath,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: widget.firstTag,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                  backgroundImage: NetworkImage(
                                    widget.profImagePath,
                                  ),
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
                      ),

                      Spacer(),
                      Text(
                        widget.time,
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    ],
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
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc(widget.postUid)
                      .get(),
                  builder: (context, asyncSnapshot) {
                    int currentLikes =
                        asyncSnapshot.data?.data()?["likesCount"] ??
                        widget.likes;
                    int currentComments =
                        asyncSnapshot.data?.data()?["commentsCount"] ??
                        widget.comments;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shrinkLikesFormula(currentLikes),
                          style: TextStyle(color: Colors.amber, fontSize: 21),
                        ),
                        GestureDetector(
                          onDoubleTap: () {},
                          onTap: () {
                            if (likedPosts.contains(widget.postUid)) {
                              likedPosts.remove(widget.postUid);
                              sharedPref.setStringList(
                                "likedPosts",
                                likedPosts,
                              );
                              int likes = currentLikes - 1;
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(widget.postUid)
                                  .update({"likesCount": likes});
                              setState(() {
                                isLiked = false;
                              });
                            } else {
                              likedPosts.add(widget.postUid);
                              sharedPref.setStringList(
                                "likedPosts",
                                likedPosts,
                              );
                              int likes = currentComments + 1;
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(widget.postUid)
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
                          shrinkLikesFormula(currentComments),
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 21,
                          ),
                        ),
                        Icon(Icons.message, color: Colors.blue[300], size: 30),
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: readComments(widget.postUid),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('حدث خطأ ما! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final comments = snapshot.data!;
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
                            return Comment();
                          },
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
