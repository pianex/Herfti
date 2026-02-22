// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/image_functions.dart';
import 'package:project_a/core/functions/show_alert.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';
import 'package:project_a/core/functions/token.dart';
import 'package:project_a/core/functions/validators.dart';
import 'package:project_a/core/models/prof_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_home_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';
import 'package:project_a/view/widgets/id_category_card.dart';

int accSelectedCategory = 0;
String accSselectedCategoryString = "";

class ProfAccountPage extends StatefulWidget {
  const ProfAccountPage({super.key});

  @override
  State<ProfAccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<ProfAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? image;
  String countryValue = '🇩🇿    Algeria';
  String stateValue = '';
  String cityValue = '';
  String finalState = "";
  String finalCity = "";
  bool infosLoaded = false;
  void selectImage({required ImageSource imageSource}) async {
    image = await pickImage(context, imageSource);
    setState(() {});
  }

  // ignore: prefer_final_fields
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      accSelectedCategory = 0;
      accSselectedCategoryString = '';
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currentImagePath = sharedPref.getString("imagePath");
    String googleImagePath = sharedPref.getString("googleImagePath")!;
    String email = sharedPref.getString("email")!;
    String name = sharedPref.getString("name")!;
    String desc = sharedPref.getString("desc")!;
    String phone = sharedPref.getString("phone")!;
    String state = sharedPref.getString("state")!;
    String city = sharedPref.getString("city")!;
    if (!infosLoaded) {
      nameController.text = name;
      descController.text = desc;
      phoneController.text = phone;
      stateValue = state;
      cityValue = city;
      infosLoaded = true;
    }
    if (accSelectedCategory == 0) {
      accSelectedCategory = sharedPref.getInt("category")!;
      accSselectedCategoryString = sharedPref.getString("categoryStr")!;
    }

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
        body: Form(
          key: _formKey,
          child: ListView(
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
                                  currentImagePath ?? googleImagePath,
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
                  currentCity: cityValue,
                  currentState: stateValue,
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
                  onStateChanged: (newState) {
                    if (newState != null) {
                      stateValue = newState;
                    }
                  },
                  onCityChanged: (newCity) {
                    if (newCity != null) {
                      cityValue = newCity;
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
                      isAccPage: true,

                      category: "كهربائي",
                      image: "assets/images/Electrician.jpeg",
                      sellerType: 1,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 1;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "خبير التبريد",
                      image: "assets/images/frigouriste.jpeg",
                      sellerType: 2,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 2;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "بناء",
                      image: "assets/images/macon.png",
                      sellerType: 3,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 3;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "ميكانيكي",
                      image: "assets/images/mechanic.jpg",
                      sellerType: 4,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 4;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "طلاء",
                      image: "assets/images/painter.jpg",
                      sellerType: 5,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 5;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,
                      category: "سباك",
                      image: "assets/images/plumber.jpg",
                      sellerType: 6,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 6;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "تلحيم",
                      image: "assets/images/soudeur.jpeg",
                      sellerType: 7,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 7;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "نجار",
                      image: "assets/images/najjar.jpg",
                      sellerType: 8,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 8;
                        });
                      },
                    ),
                    IdCategoryCard(
                      isAccPage: true,

                      category: "خياط",
                      image: "assets/images/knitting.jpeg",
                      sellerType: 9,
                      onTap: () {
                        setState(() {
                          accSelectedCategory = 9;
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
                      if (accSelectedCategory != 0 &&
                          accSselectedCategoryString.isNotEmpty) {
                        showProgressDialog(
                          context,
                          Size(
                            MediaQuery.of(context).size.width / 2,
                            MediaQuery.of(context).size.width / 2,
                          ),
                        );
                        if (accSelectedCategory != 0) {
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
                                .then((link) => imagePath = link)
                                .whenComplete(() {
                                  if (imagePath.isNotEmpty) {
                                    sharedPref.setString(
                                      "imagePath",
                                      imagePath,
                                    );
                                  }
                                });
                          }
                          String token = await getToken();
                          List<String> tokens = [];
                          tokens.add(token);

                          Map<String, dynamic> json = ProfModel(
                            uid: email,
                            name: nameController.text,
                            imagePath: imagePath.isNotEmpty
                                ? imagePath
                                : currentImagePath ?? googleImagePath,
                            phone: phoneController.text,
                            email: email,
                            description: descController.text,
                            xp: 0,
                            services: "",
                            travel: true,
                            available: false,
                            type: accSelectedCategory,
                            category: accSselectedCategoryString,
                            saves: 0,
                            timeAdded: DateTime.now().toString(),
                            country: countryValue,
                            state: stateValue,
                            city: cityValue,
                            tokens: tokens,
                          ).toJson();
                          FirebaseFirestore.instance
                              .collection("Profs")
                              .doc(email)
                              .update(json)
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

                                sharedPref.setString("state", stateValue);
                                sharedPref.setString("city", cityValue);
                                sharedPref.setInt(
                                  "category",
                                  accSelectedCategory,
                                );
                                sharedPref.setString(
                                  "categoryStr",
                                  accSselectedCategoryString,
                                );
                              })
                              .whenComplete(() {
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
