import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/view/pages/prof_profile.dart';
import 'package:project_a/view/widgets/comment.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
    required this.imagePath,
    required this.name,
    required this.text,
    required this.type,
    required this.time,
    required this.likes,
    required this.firstTag,
    required this.secondTag,
  });
  final String imagePath;
  final String name;
  final String type;
  final String time;
  final String text;
  final int likes;
  final String firstTag;
  final String secondTag;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
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
        body: ListView(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: widget.firstTag,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue[900],
                              backgroundImage: AssetImage(widget.imagePath),
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
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 1),
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            Hero(
              tag: widget.imagePath,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: asset.height,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(widget.imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
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
                Icon(Icons.message, color: Colors.blue[300], size: 30),
              ],
            ),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
            Comment(),
          ],
        ),
      ),
    );
  }
}
