import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/account_page.dart';
import 'package:project_a/view/pages/new_post_page.dart';
import 'package:project_a/view/widgets/cust_drawer.dart';
import 'package:project_a/view/widgets/post_card.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfHomePage extends StatelessWidget {
  const ProfHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? imagePath = sharedPref.getString("imagePath");
    String googleImagePath = sharedPref.getString("googleImagePath")!;
    print(googleImagePath);
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
              child: Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: 40,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),

                child: Image.network(
                  imagePath ?? googleImagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: Colors.white, size: 25);
                  },
                ),
                // Icon(Icons.person, color: Colors.white),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => NewPostPage()),
            );
          },
          child: Icon(Icons.post_add, size: 30),
        ),
      ),
    );
  }
}
