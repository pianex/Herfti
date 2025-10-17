import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
            "من نحن",
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
            // Container(
            //   height: double.infinity,
            //   width: double.infinity,
            //   child: Image.asset("assets/gifs/about.gif", fit: BoxFit.cover),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "تم تطوير هذا التطبيق من طرف فريق\nنت مهن للأشغال المتعددة",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ),
                ),

                Spacer(),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(color: appBarColor),
                  child: Center(
                    child: Text(
                      "© شركة نت مهن للأشغال المختلفة\n جميع الحقوق محفوظة 2025.",
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
