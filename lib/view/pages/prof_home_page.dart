import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/pages/account_page.dart';
import 'package:project_a/view/widgets/cust_drawer.dart';
import 'package:project_a/view/widgets/post_card.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfHomePage extends StatelessWidget {
  const ProfHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: CustDrawer(),

        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: Builder(
            builder:
                (context) => // Ensure Scaffold is in context
                MaterialButton(
                  child: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          title: Text(
            "حرفتي",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.message, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // Align(
            //   alignment: AlignmentGeometry.center,
            //   child: TitleText(title: "استكشف التصنيفات"),
            // ),
            // CategoriesSlider(),
            TitleText(title: "آخر المنشورات"),
            PostCard(
              firstTag: "aaa",
              secondTag: "assets/images/plumber.jpg",
              name: "مصطفى",
              type: "سباك",
              time: "2 دقيقة",
              imagePath: "assets/images/plumber.jpg",
              text: "أحد أعمالي، أرجوا أن تنال إعجابكم!",
              likes: 165,
            ),
            PostCard(
              firstTag: "ccc",
              secondTag: "assets/images/najjar.jpg",
              name: "أشرف",
              type: "نجار",
              time: "37 دقيقة",
              imagePath: "assets/images/najjar.jpg",
              text: "نخدموا غير الخدمة المليحة صاحبي",
              likes: 165,
            ),
          ],
        ),
      ),
    );
  }
}
