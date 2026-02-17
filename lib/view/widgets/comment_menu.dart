import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';

class CommentMenu extends StatefulWidget {
  const CommentMenu({super.key, required this.postUid, required this.index});

  final String postUid;

  final int index;

  @override
  State<CommentMenu> createState() => _CommentMenuState();
}

class _CommentMenuState extends State<CommentMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: () {},
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.yellow[800]!,
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "تعديل",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {},
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange[700]!,
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "إبلاغ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
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
            comments.removeAt(widget.index);
            FirebaseFirestore.instance
                .collection("Posts")
                .doc(widget.postUid)
                .update({
                  "comments": comments,
                  "commentsCount": comments.length,
                })
                .whenComplete(() {
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red[700]!,
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "حذف",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
