import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/core/models/prof_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_home_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class ProfInfoPage extends StatefulWidget {
  const ProfInfoPage({super.key});

  @override
  State<ProfInfoPage> createState() => _ProfInfoPageState();
}

class _ProfInfoPageState extends State<ProfInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = sharedPref.getString("name")!;
    String email = sharedPref.getString("email")!;
    nameController.text = name;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () async {
              sharedPref.clear();
              await googleSignOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "معلومات الحساب",
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: appBarColor,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),

            CustTextFormField(label: "الإسم", controller: nameController),

            CustTextFormField(
              label: "الوصف",
              controller: TextEditingController(),
            ),
            CustTextFormField(
              label: "رقم الهاتف",
              controller: TextEditingController(),
            ),

            CustButton(
              title: "حفظ",
              icon: Icons.save,
              onTap: () {
                String uid = DateTime.now().millisecondsSinceEpoch.toString();
                Map<String, dynamic> json = ProfModel(
                  uid: uid,
                  name: name,
                  imagePath: "imagePath",
                  phone: phoneController.text,
                  email: email,
                  description: descController.text,
                  type: 100,
                  saves: 0,
                  timeAdded: DateTime.now().toString(),
                ).toJson();
                FirebaseFirestore.instance
                    .collection("Profs")
                    .doc(uid)
                    .set(json)
                    .whenComplete(() {
                      sharedPref.setString("userType", "prof");
                      sharedPref.setString("uid", uid);
                    });
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => ProfHomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
