import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/widgets/cust_button.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

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
            "منشور جديد",
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
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,

              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 25),
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hint: Text(
                    "أكتب ما تفكر به ...",
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  ),
                ),
              ),
            ),
            CustButton(title: "إضافة صورة", icon: Icons.photo),
            CustButton(title: "نشر", icon: Icons.post_add_outlined),
          ],
        ),
      ),
    );
  }
}
