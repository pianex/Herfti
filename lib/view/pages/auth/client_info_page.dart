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
import 'package:project_a/core/functions/token.dart';
import 'package:project_a/core/functions/validators.dart';
import 'package:project_a/core/models/client_model.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/client_home_page.dart';
import 'package:project_a/view/widgets/cust_button.dart';
import 'package:project_a/view/widgets/cust_text_form_field.dart';

class ClientInfoPage extends StatefulWidget {
  const ClientInfoPage({super.key});

  @override
  State<ClientInfoPage> createState() => _ClientInfoPageState();
}

class _ClientInfoPageState extends State<ClientInfoPage> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    String name = sharedPref.getString("name")!;
    String email = sharedPref.getString("email")!;
    nameController.text = name;
    String googleImagePath = sharedPref.getString("googleImagePath")!;
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

              CustButton(
                title: "حفظ",
                icon: Icons.save,
                onTap: () async {
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
                              "Clients/ProPics/${email.toLowerCase().replaceAll("@gmail.com", "")}.jpg",
                            )
                            .putFile(image!);
                        TaskSnapshot snapshot = await uploadTask;
                        // ignore: unused_local_variable
                        String downloadlUrl = await snapshot.ref
                            .getDownloadURL()
                            .then((link) => imagePath = link)
                            .whenComplete(() {
                              sharedPref.setString("imagePath", imagePath);
                            });
                      }
                      String token = await getToken();
                      List<String> tokens = [];
                      tokens.add(token);

                      Map<String, dynamic> json = ClientModel(
                        uid: email,
                        name: name,
                        imagePath: imagePath.isNotEmpty
                            ? imagePath
                            : googleImagePath,
                        phone: phoneController.text,
                        email: email,
                        facebook: "",
                        instagram: "",
                        whatsapp: phoneController.text,
                        description: descController.text,
                        country: countryValue,
                        state: stateValue,
                        city: cityValue,
                        timeAdded: DateTime.now().toString(),
                        tokens: tokens,
                        savedProfs: [],
                        likedPosts: [],
                      ).toJson();

                      FirebaseFirestore.instance
                          .collection("Clients")
                          .doc(email)
                          .set(json)
                          .then((value) {
                            sharedPref.setString("userType", "client");
                            sharedPref.setString("uid", email);
                            sharedPref.setString("name", name);
                            sharedPref.setString("desc", descController.text);
                            sharedPref.setString("phone", phoneController.text);
                            sharedPref.setString(
                              "googleImagePath",
                              googleImagePath,
                            );

                            sharedPref.setString("state", stateValue);
                            sharedPref.setString("city", cityValue);
                            Navigator.pushAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ClientHomePage(),
                              ),
                              (route) => false,
                            );
                          });
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
