import 'package:flutter/material.dart';

class PostMenu extends StatelessWidget {
  const PostMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            // borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[700],
            // borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            // borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
