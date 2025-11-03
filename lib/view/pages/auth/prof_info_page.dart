// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/core/functions/image_functions.dart';
import 'package:project_a/core/functions/show_alert.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';
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
  void selectImage({required ImageSource imageSource}) async {
    image = await pickImage(context, imageSource);
    setState(() {});
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // selectedCategory = 0;
    // selectedCategoryString = "";
    String name = sharedPref.getString("name")!;
    String email = sharedPref.getString("email")!;
    String googleImagePath = sharedPref.getString("googleImagePath")!;
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
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      selectImage(imageSource: ImageSource.camera);
                    },
                    child: Stack(
                      alignment: AlignmentGeometry.bottomRight,

                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: appBarColor,
                            shape: BoxShape.circle,
                          ),
                          child: image != null
                              ? Image.file(image!, fit: BoxFit.cover)
                              : Image.network(
                                  googleImagePath,
                                  fit: BoxFit.cover,
                                ),
                          //  Icon(
                          //     Icons.person,
                          //     size: 80,
                          //     color: Colors.white,
                          //   ),
                        ),

                        Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (stateValue.isNotEmpty && cityValue.isNotEmpty) {
                      if (selectedCategory != 0 &&
                          selectedCategoryString.isNotEmpty) {
                        showProgressDialog(
                          context,
                          Size(
                            MediaQuery.of(context).size.width / 2,
                            MediaQuery.of(context).size.width / 2,
                          ),
                        );
                        if (selectedCategory != 0) {
                          String imagePath = '';
                          if (image != null) {
                            UploadTask uploadTask = FirebaseStorage.instance
                                .ref()
                                .child(
                                  "Profs/ProPics/${email.toLowerCase().replaceAll("@gmail.com", "")}.jpg",
                                )
                                .putFile(image!);
                            TaskSnapshot snapshot = await uploadTask;
                            // ignore: unused_local_variable
                            String downloadlUrl = await snapshot.ref
                                .getDownloadURL()
                                .then((link) => imagePath = link);
                          }

                          Map<String, dynamic> json = ProfModel(
                            uid: email,
                            name: name,
                            imagePath: imagePath.isNotEmpty
                                ? imagePath
                                : googleImagePath,
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
                                sharedPref.setString("name", name);
                                sharedPref.setString(
                                  "desc",
                                  descController.text,
                                );
                                sharedPref.setString(
                                  "phone",
                                  phoneController.text,
                                );
                                sharedPref.setString("imagePath", imagePath);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProfHomePage(),
                                  ),
                                  (route) => false,
                                );
                              });
                        }
                      } else {
                        showAlert(context, "من فضلك اختر المهنة الخاصة بك.");
                      }
                    } else {
                      showAlert(
                        context,
                        "أدخل معلومات الولاية و المدينة من فضلك.",
                      );
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
