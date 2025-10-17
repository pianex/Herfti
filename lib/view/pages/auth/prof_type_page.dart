import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class ProfTypePage extends StatelessWidget {
  const ProfTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(backgroundColor: appBarColor),
      ),
    );
  }
}
