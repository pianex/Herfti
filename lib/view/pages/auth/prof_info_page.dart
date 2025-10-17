import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class ProfInfoPage extends StatelessWidget {
  const ProfInfoPage({super.key});

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
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: appBarColor,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),

            CustTextFormField(
              label: "الإسم",
              controller: TextEditingController(),
            ),

            CustTextFormField(
              label: "الوصف",
              controller: TextEditingController(),
            ),
            CustTextFormField(
              label: "رقم الهاتف",
              controller: TextEditingController(),
            ),
            CustTextFormField(
              label: "البريد الإلكتروني",
              controller: TextEditingController(),
            ),
            CustButton(title: "حفظ", icon: Icons.save),
          ],
        ),
      ),
    );
  }
}
