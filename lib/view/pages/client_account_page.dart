// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/image_functions.dart';
import 'package:project_a/core/functions/show_progress_dialog.dart';
import 'package:project_a/core/functions/validators.dart';
import 'package:project_a/core/models/client_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class ClientAccountPage extends StatefulWidget {
  const ClientAccountPage({super.key});

  @override
  State<ClientAccountPage> createState() => _ClientAccountPageState();
}

class _ClientAccountPageState extends State<ClientAccountPage> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController xpController = TextEditingController();
  bool travelValue = true;
  bool availableValue = true;
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
  Widget build(BuildContext context) {
    String? currentImagePath = sharedPref.getString("imagePath");
    String googleImagePath = sharedPref.getString("googleImagePath")!;
    String email = sharedPref.getString("email")!;
    String name = sharedPref.getString("name")!;
    String desc = sharedPref.getString("desc")!;
    String phone = sharedPref.getString("phone")!;
    String facebook = sharedPref.getString("facebook") ?? "";
    String instagram = sharedPref.getString("instagram") ?? "";
    String whatsapp = sharedPref.getString("whatsapp") ?? phone;
    String state = sharedPref.getString("state")!;
    String city = sharedPref.getString("city")!;

    if (!infosLoaded) {
      nameController.text = name;
      descController.text = desc;
      phoneController.text = phone;
      facebookController.text = facebook;
      instagramController.text = instagram;
      whatsappController.text = whatsapp;
      stateValue = state;
      cityValue = city;
      infosLoaded = true;
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
          actions: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.white, size: 30),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (stateValue.isNotEmpty && cityValue.isNotEmpty) {
                    showProgressDialog(
                      context,
                      Size(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.width / 2,
                      ),
                    );
                    String imagePath = '';
                    if (image != null) {
                      UploadTask uploadTask = FirebaseStorage.instance
                          .ref()
                          .child(
                            "Clients/ClientPics/${email.toLowerCase().replaceAll("@gmail.com", "")}.jpg",
                          )
                          .putFile(image!);
                      TaskSnapshot snapshot = await uploadTask;
                      // ignore: unused_local_variable
                      String downloadlUrl = await snapshot.ref
                          .getDownloadURL()
                          .then((link) => imagePath = link)
                          .whenComplete(() {
                            if (imagePath.isNotEmpty) {
                              sharedPref.setString("imagePath", imagePath);
                            }
                          });
                    }
                    Map<String, dynamic> json = ClientModel(
                      uid: email,
                      name: nameController.text,
                      imagePath: imagePath.isNotEmpty
                          ? imagePath
                          : currentImagePath ?? googleImagePath,
                      phone: phoneController.text,
                      email: email,
                      facebook: facebookController.text,
                      instagram: instagramController.text,
                      whatsapp: whatsappController.text,
                      description: descController.text,
                      country: countryValue,
                      state: stateValue,
                      city: cityValue,
                      timeAdded: DateTime.now().toString(),
                      tokens: [],
                      savedProfs: [],
                      likedPosts: [],
                    ).toJson();
                    FirebaseFirestore.instance
                        .collection("Clients")
                        .doc(email)
                        .update(json)
                        .whenComplete(() {
                          sharedPref.setString("uid", email);
                          sharedPref.setString("name", name);
                          sharedPref.setString("desc", descController.text);
                          sharedPref.setString("phone", phoneController.text);
                          sharedPref.setString(
                            "facebook",
                            facebookController.text,
                          );
                          sharedPref.setString(
                            "instagram",
                            instagramController.text,
                          );
                          sharedPref.setString(
                            "whatsapp",
                            whatsappController.text,
                          );
                          sharedPref.setString("state", stateValue);
                        })
                        .whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                  }
                }
              },
            ),
          ],
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
                label: "رقم الهاتف",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (text) {
                  return phoneValidator(text);
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
                label: "رابط الفيسبوك",
                controller: facebookController,
              ),
              CustTextFormField(
                label: "رابط الانستغرام",
                controller: instagramController,
              ),
              CustTextFormField(
                label: "رقم الواتساب",
                controller: whatsappController,
                keyboardType: TextInputType.phone,
                validator: (text) {
                  return whatsappValidator(text);
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

              // CustButton(
              //   title: "حفظ",
              //   icon: Icons.save,
              //   onTap: () async {
              //     if (_formKey.currentState!.validate()) {
              //       if (stateValue.isNotEmpty && cityValue.isNotEmpty) {
              //         if (accSelectedCategory != 0 &&
              //             accSselectedCategoryString.isNotEmpty) {
              //           showProgressDialog(
              //             context,
              //             Size(
              //               MediaQuery.of(context).size.width / 2,
              //               MediaQuery.of(context).size.width / 2,
              //             ),
              //           );
              //           if (accSelectedCategory != 0) {
              //             String imagePath = '';
              //             if (image != null) {
              //               UploadTask uploadTask = FirebaseStorage.instance
              //                   .ref()
              //                   .child(
              //                     "Profs/ProPics/${email.toLowerCase().replaceAll("@gmail.com", "")}.jpg",
              //                   )
              //                   .putFile(image!);
              //               TaskSnapshot snapshot = await uploadTask;
              //               // ignore: unused_local_variable
              //               String downloadlUrl = await snapshot.ref
              //                   .getDownloadURL()
              //                   .then((link) => imagePath = link)
              //                   .whenComplete(() {
              //                     if (imagePath.isNotEmpty) {
              //                       sharedPref.setString(
              //                         "imagePath",
              //                         imagePath,
              //                       );
              //                     }
              //                   });
              //             }
              //             String token = await getToken();
              //             List<String> tokens = [];
              //             tokens.add(token);

              //             Map<String, dynamic> json = ProfModel(
              //               uid: email,
              //               name: nameController.text,
              //               imagePath: imagePath.isNotEmpty
              //                   ? imagePath
              //                   : currentImagePath ?? googleImagePath,
              //               phone: phoneController.text,
              //               facebook: facebookController.text,
              //               instagram: instagramController.text,
              //               whatsapp: whatsappController.text,
              //               email: email,
              //               description: descController.text,
              //               xp: xpController.text.isNotEmpty
              //                   ? int.parse(xpController.text)
              //                   : 0,
              //               services: servicesController.text,
              //               travel: travelValue,
              //               available: availableValue,
              //               type: accSelectedCategory,
              //               category: accSselectedCategoryString,
              //               saves: 0,
              //               timeAdded: DateTime.now().toString(),
              //               country: countryValue,
              //               state: stateValue,
              //               city: cityValue,
              //               tokens: tokens,
              //             ).toJson();
              //             FirebaseFirestore.instance
              //                 .collection("Profs")
              //                 .doc(email)
              //                 .update(json)
              //                 .whenComplete(() {
              //                   sharedPref.setString("userType", "prof");
              //                   sharedPref.setString("uid", email);
              //                   sharedPref.setString("name", name);
              //                   sharedPref.setString(
              //                     "desc",
              //                     descController.text,
              //                   );
              //                   sharedPref.setString(
              //                     "phone",
              //                     phoneController.text,
              //                   );
              //                   sharedPref.setString(
              //                     "facebook",
              //                     facebookController.text,
              //                   );
              //                   sharedPref.setString(
              //                     "instagram",
              //                     instagramController.text,
              //                   );
              //                   sharedPref.setString(
              //                     "whatsapp",
              //                     whatsappController.text,
              //                   );
              //                   sharedPref.setString(
              //                     "services",
              //                     servicesController.text,
              //                   );
              //                   sharedPref.setInt(
              //                     "xp",
              //                     xpController.text.isNotEmpty
              //                         ? int.parse(xpController.text)
              //                         : 0,
              //                   );
              //                   sharedPref.setBool("travel", travelValue);
              //                   sharedPref.setBool("available", availableValue);
              //                   sharedPref.setString("state", stateValue);
              //                   sharedPref.setString("city", cityValue);
              //                   sharedPref.setInt(
              //                     "category",
              //                     accSelectedCategory,
              //                   );
              //                   sharedPref.setString(
              //                     "categoryStr",
              //                     accSselectedCategoryString,
              //                   );
              //                 })
              //                 .whenComplete(() {
              //                   Navigator.pushAndRemoveUntil(
              //                     context,
              //                     CupertinoPageRoute(
              //                       builder: (context) => ProfHomePage(),
              //                     ),
              //                     (route) => false,
              //                   );
              //                 });
              //           }
              //         } else {
              //           showAlert(context, "من فضلك اختر المهنة الخاصة بك.");
              //         }
              //       } else {
              //         showAlert(
              //           context,
              //           "أدخل معلومات الولاية و المدينة من فضلك.",
              //         );
              //       }
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
