import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

Future showProgressDialog(BuildContext context, Size size) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(3),
        height: size.width * 0.5,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          color: dialogsColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    ),
  );
}
