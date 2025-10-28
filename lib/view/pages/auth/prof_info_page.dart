// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/core/functions/validators.dart';
import 'package:project_a/core/models/prof_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_home_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';
import 'package:project_a/view/widgets/id_category_card.dart';

int selectedCategory = 0;
String selectedCategoryString = "";

class ProfInfoPage extends StatefulWidget {
  const ProfInfoPage({super.key});

  @override
  State<ProfInfoPage> createState() => _ProfInfoPageState();
}

class _ProfInfoPageState extends State<ProfInfoPage> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String countryValue = '🇩🇿    Algeria';
  String stateValue = '';
  String cityValue = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              // ignore: use_build_context_synchronously
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
        body: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
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
                controller: nameController,
                validator: (text) {
                  return nameValidator(text);
                },
              ),

              CustTextFormField(
                label: "الوصف",
                controller: descController,
                validator: (text) {
                  return nameValidator(text);
                },
              ),
              CustTextFormField(
                label: "رقم الهاتف",
                controller: phoneController,
                validator: (text) {
                  return phoneValidator(text);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: CSCPicker(
                  currentCountry: "🇩🇿    Algeria",
                  disableCountry: true,
                  countryFilter: [CscCountry.Algeria],
                  dropdownItemStyle: TextStyle(color: Colors.black),
                  selectedItemStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  children: [
                    IdCategoryCard(
                      category: "كهربائي",
                      image: "assets/images/Electrician.jpeg",
                      sellerType: 1,
                      onTap: () {
                        setState(() {
                          selectedCategory = 1;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "خبير التبريد",
                      image: "assets/images/frigouriste.jpeg",
                      sellerType: 2,
                      onTap: () {
                        setState(() {
                          selectedCategory = 2;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "بناء",
                      image: "assets/images/macon.png",
                      sellerType: 3,
                      onTap: () {
                        setState(() {
                          selectedCategory = 3;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "ميكانيكي",
                      image: "assets/images/mechanic.jpg",
                      sellerType: 4,
                      onTap: () {
                        setState(() {
                          selectedCategory = 4;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "طلاء",
                      image: "assets/images/painter.jpg",
                      sellerType: 5,
                      onTap: () {
                        setState(() {
                          selectedCategory = 5;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "سباك",
                      image: "assets/images/plumber.jpg",
                      sellerType: 6,
                      onTap: () {
                        setState(() {
                          selectedCategory = 6;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "تلحيم",
                      image: "assets/images/soudeur.jpeg",
                      sellerType: 7,
                      onTap: () {
                        setState(() {
                          selectedCategory = 7;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 8,
                      onTap: () {
                        setState(() {
                          selectedCategory = 8;
                        });
                      },
                    ),
                    IdCategoryCard(
                      category: "خياط",
                      image: "assets/images/knitting.jpeg",
                      sellerType: 9,
                      onTap: () {
                        setState(() {
                          selectedCategory = 9;
                        });
                      },
                    ),
                  ],
                ),
              ),
              CustButton(
                title: "حفظ",
                icon: Icons.save,
                onTap: () {
                  if (image != null) {
                    if (_formKey.currentState!.validate()) {
                      if (stateValue.isNotEmpty && cityValue.isNotEmpty) {
                        if (selectedCategory != 0) {
                          Map<String, dynamic> json = ProfModel(
                            uid: email,
                            name: name,
                            imagePath: "imagePath",
                            phone: phoneController.text,
                            email: email,
                            description: descController.text,

                            type: selectedCategory,
                            category: selectedCategoryString,
                            saves: 0,
                            timeAdded: DateTime.now().toString(),
                            country: countryValue,
                            state: stateValue,
                            city: cityValue,
                          ).toJson();
                          FirebaseFirestore.instance
                              .collection("Profs")
                              .doc(email)
                              .set(json)
                              .whenComplete(() {
                                sharedPref.setString("userType", "prof");
                                sharedPref.setString("uid", email);
                              });
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProfHomePage(),
                            ),
                          );
                        }
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
