import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

Future showAlert(BuildContext context, String title) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(3),
        height: MediaQuery.of(context).size.width / 2,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: dialogsColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
