import 'package:flutter/material.dart';

class PostMenu extends StatelessWidget {
  const PostMenu({super.key});

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
          onDoubleTap: () {},
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
