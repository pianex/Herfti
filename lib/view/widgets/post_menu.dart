import 'package:flutter/material.dart';
import 'package:project_a/core/functions/post_functions.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';

class PostMenu extends StatelessWidget {
  const PostMenu({super.key, required this.isMe, required this.postUid});
  final bool isMe;
  final String postUid;

  @override
  Widget build(BuildContext context) {
    return isMe
        ? Column(
            children: [
              // GestureDetector(
              //   onDoubleTap: () {},
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: Colors.yellow[800]!,
              //       // borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "تعديل",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 23,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        content: const Text(
                          "هل تريد حقا حذف هذالمنشور؟",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "إلغاء",
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onDoubleTap: () {},
                            onTap: () async {
                              showProgressDialog(
                                context,
                                Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.width,
                                ),
                              );
                              deletePost(postUid).whenComplete(() {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            child: const Text(
                              "حذف",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
          )
        : Column(
            children: [
              GestureDetector(
                onDoubleTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[700]!,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "إخفاء",
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
