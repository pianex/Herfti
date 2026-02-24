import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });
  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        // height: 30,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
