import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/widgets/prof_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,

        // drawer: CustDrawer(),
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "حرفيون",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ProfessionalCard(
              tag: "zzz",
              name: "مصطفى",
              category: "سباك",
              image: "assets/images/plumber.jpg",
              saves: 3592,
              sellerType: 3,
            ),
          ],
        ),
      ),
    );
  }
}
