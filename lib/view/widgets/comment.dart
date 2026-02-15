import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/widgets/post_menu.dart';

class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.name,
    required this.text,
    required this.imagePath,
    required this.postUid,
    required this.index,
  });
  final String name;
  final String text;
  final String imagePath;
  final String postUid;
  final int index;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        showPopover(
          context: context,
          bodyBuilder: (context) => PostMenu(),
          width: 200,
          height: 150,
          backgroundColor: Colors.red[700]!,
          radius: 20,
          arrowHeight: 20,
          arrowWidth: 30,
        );
        List comments = await FirebaseFirestore.instance
            .collection("Posts")
            .doc(widget.postUid)
            .get()
            .then((doc) {
              return doc.data()!["comments"] ?? [];
            });
        comments.removeAt(widget.index);
        FirebaseFirestore.instance
            .collection("Posts")
            .doc(widget.postUid)
            .update({"comments": comments, "commentsCount": comments.length})
            .whenComplete(() {
              setState(() {});
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: appBarColor,
                backgroundImage: NetworkImage(widget.imagePath),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  // height: 50,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    border: Border.all(color: Colors.grey[500]!, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
