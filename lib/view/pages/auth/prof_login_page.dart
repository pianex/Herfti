import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/view/pages/auth/prof_info_page.dart';
import 'package:project_a/view/widgets/cust_progress_indicator.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfLoginPage extends StatefulWidget {
  const ProfLoginPage({super.key});

  @override
  State<ProfLoginPage> createState() => _ProfLoginPageState();
}

class _ProfLoginPageState extends State<ProfLoginPage> {
  bool isLoading = false;
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
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset("assets/images/step.jpg", fit: BoxFit.cover),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black.withAlpha(180)),
            ),
            isLoading
                ? CustProgressIndicator()
                : Center(
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
                            setState(() {
                              isLoading = true;
                            });
                            signInWithGoogle(
                              context: context,
                              onSuccess: () {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfInfoPage(),
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/google_png.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
