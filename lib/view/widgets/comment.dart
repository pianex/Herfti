import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/widgets/comment_menu.dart';

class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.text,
    required this.postUid,
    required this.index,
    required this.userName,
    required this.userImagePath,
    required this.profType,
    required this.userUid,
    required this.uid,
    required this.timeAdded,
  });
  final String uid;
  final String timeAdded;
  final String postUid;
  final String userUid;
  final String userName;
  final String profType;
  final String userImagePath;
  final String text;
  final int index;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final email = sharedPref.getString("email") ?? "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (widget.userUid == email) {
          showPopover(
            context: context,
            bodyBuilder: (context) =>
                CommentMenu(postUid: widget.postUid, index: widget.index),
            width: 250,
            height: 150,
            backgroundColor: Colors.red[700]!,
            radius: 20,
            arrowHeight: 20,
            arrowWidth: 30,
          );
        }
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
                backgroundImage: NetworkImage(widget.userImagePath),
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
                          widget.userName,
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
