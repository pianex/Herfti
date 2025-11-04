import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? image;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = sharedPref.getString("email")!;
    String name = sharedPref.getString("name")!;
    nameController.text = name;
    String desc = sharedPref.getString("desc")!;
    descController.text = desc;
    String phone = sharedPref.getString("phone")!;
    phoneController.text = phone;
    String imagePath = sharedPref.getString("imagePath")!;

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
            "حسابي",
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
              height: 150,
              width: 150,
              margin: EdgeInsetsGeometry.all(15),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(imagePath, fit: BoxFit.cover),
            ),
            CustTextFormField(label: "الإسم", controller: nameController),
            CustTextFormField(label: "الوصف", controller: descController),
            CustTextFormField(label: "رقم الهاتف", controller: phoneController),
            CustButton(title: "حفظ", icon: Icons.save),
          ],
        ),
      ),
    );
  }
}
