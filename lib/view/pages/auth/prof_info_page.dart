import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/core/models/prof_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_home_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';
import 'package:project_a/view/widgets/id_category_card.dart';

class ProfInfoPage extends StatefulWidget {
  const ProfInfoPage({super.key});

  @override
  State<ProfInfoPage> createState() => _ProfInfoPageState();
}

class _ProfInfoPageState extends State<ProfInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String countryValue = '🇩🇿    Algeria';
  String stateValue = '';
  String cityValue = '';
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

            CustTextFormField(label: "الوصف", controller: descController),
            CustTextFormField(label: "رقم الهاتف", controller: phoneController),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CSCPicker(
                currentCountry: "🇩🇿    Algeria",
                disableCountry: true,
                countryFilter: [CscCountry.Algeria],
                dropdownItemStyle: TextStyle(color: Colors.black),
                selectedItemStyle: TextStyle(color: Colors.white, fontSize: 20),
                defaultCountry: CscCountry.Algeria,
                dropdownDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledDropdownDecoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                onCountryChanged: (country) {},
                onStateChanged: (state) {
                  if (state != null) {
                    stateValue = state;
                  }
                },
                onCityChanged: (city) {
                  if (city != null) {
                    cityValue = city;
                  }
                },
              ),
            ),
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  children: [
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 0,
                    ),
                  ],
                ),
              ),
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
                  country: countryValue,
                  state: stateValue,
                  city: cityValue,
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
