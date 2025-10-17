import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title, this.textAlign});
  final String title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        title,
        // textDirection: TextDirection.rtl,
        // textAlign: textAlign ?? TextAlign.right,
        style: TextStyle(
          fontSize: 23,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
