import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/pages/auth/client_login_page.dart';
import 'package:project_a/view/pages/auth/prof_login_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text(
            "التسجيل",
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
              child: Image.asset(
                "assets/images/workers.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black.withAlpha(150)),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  // CustButton(
                  //   title: "سجل كصاحب مشاريع",
                  //   icon: Icons.handshake,
                  // ),
                  CustButton(
                    title: "سجل كصاحب عمل",
                    icon: Icons.document_scanner_sharp,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfLoginPage(),
                        ),
                      );
                    },
                  ),
                  CustButton(
                    title: "سجل كباحث عن عامل",
                    icon: Icons.search,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientLoginPage(),
                        ),
                      );
                    },
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
