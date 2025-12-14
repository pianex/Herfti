import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/view/widgets/contact_button.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfessionalProfile extends StatelessWidget {
  const ProfessionalProfile({super.key, required this.tag});
  final String tag;

  @override
  Widget build(BuildContext context) {
    Image asset = Image.network(tag, fit: BoxFit.cover);
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
            "صفحة الحرفي",
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_on, color: Colors.white),
            ),
          ],
        ),
        body: ListView(
          children: [
            Hero(
              tag: tag,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Dialog(
                        shadowColor: Colors.black,
                        child: Container(
                          width: double.infinity,
                          height: asset.height,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 5,
                            ),
                          ),
                          child: Image.network(tag, fit: BoxFit.cover),
                        ),
                      ).animate().untint(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  clipBehavior: Clip.hardEdge,
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    // borderRadius: BorderRadius.circular(15),
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(tag, fit: BoxFit.contain),
                ),
              ),
            ),
            Column(
              children: [
                TitleText(title: "مصطفى"),
                Text(
                  "سباك",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shrinkLikesFormula(3882),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 182, 67, 202),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.bookmark,
                      color: const Color.fromARGB(255, 182, 67, 202),
                      size: 40,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContactButton(label: "واتساب", icon: FontAwesomeIcons.whatsapp),
                ContactButton(label: "فيسبوك", icon: FontAwesomeIcons.facebook),
              ],
            ),
            TitleText(title: "الخدمات"),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text('''- تركيب أنابيب المياه و كل الأجهزة المتعلقة بها.
- تصليح كل الأعطال.''', style: TextStyle(fontSize: 23, color: Colors.white)),
            ),
            SizedBox(height: 10),
            TitleText(title: "المنشورات"),
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
                Image.asset("assets/images/gallery.png", fit: BoxFit.cover),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
