import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class CustButton extends StatelessWidget {
  const CustButton({
    super.key,
    required this.title,
    required this.icon,
    this.isSquared = false,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final bool? isSquared;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isSquared!
            ? Column(
                children: [
                  Icon(icon, color: Colors.white, size: 60),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 23,
                    child: Icon(icon, color: appBarColor, size: 35),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
