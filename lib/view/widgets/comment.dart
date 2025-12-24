import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.name,
    required this.text,
    required this.imagePath,
  });
  final String name;
  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: appBarColor,
              backgroundImage: NetworkImage(imagePath),
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
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        text,
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
    );
  }
}
