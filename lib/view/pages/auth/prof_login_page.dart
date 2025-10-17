import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/pages/auth/prof_info_page.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfLoginPage extends StatelessWidget {
  const ProfLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(title: "قم بتسجيل الدخول"),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 5,
                ),
                child: Divider(thickness: 2),
              ),
              TitleText(title: "سجل باستخدام Google"),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ProfInfoPage()),
                    (context) => false,
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/google_png.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
