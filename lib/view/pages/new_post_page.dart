import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/image_functions.dart';
import 'package:project_a/core/functions/validators.dart';
import 'package:project_a/core/models/post_model.dart';
import 'package:project_a/view/widgets/cust_button.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _postController = TextEditingController();
  List<File?> images = [];
  void _selectImage({required ImageSource imageSource}) async {
    File? image = await pickImage(context, imageSource);
    if (image != null && images.length < 5) {
      images.add(image);
    } else if (images.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "لا يمكنك إضافة أكثر من 5 صور",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      );
    }
    setState(() {});
  }

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
              padding: EdgeInsets.all(10),
              width: double.infinity,

              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,

                child: TextFormField(
                  controller: _postController,
                  validator: (text) {
                    return postValidator(text);
                  },
                  maxLength: 200,

                  style: TextStyle(color: Colors.white, fontSize: 25),
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    counterStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    hint: Text(
                      "أكتب ما تفكر به ...",
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(images[index]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black.withAlpha(130),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () {
                        images.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
            CustButton(
              title: "إضافة صورة من المعرض",
              icon: Icons.image,
              onTap: () {
                _selectImage(imageSource: ImageSource.gallery);
              },
            ),
            CustButton(
              title: "إضافة صورة من الكاميرا",
              icon: Icons.camera_alt,
              onTap: () {
                _selectImage(imageSource: ImageSource.camera);
              },
            ),
            CustButton(
              title: "نشر",
              icon: Icons.post_add_outlined,
              onTap: () {
                if (_formKey.currentState!.validate()) {}
                final json = PostModel(
                  uid: DateTime.now().millisecondsSinceEpoch.toString(),
                  timeAdded: DateTime.now().toString(),
                  profUid: "profUid",
                  profName: "profName",
                  profImagePath: "profImagePath",
                  text: _postController.text,
                  imagePaths: [],
                  likesCount: 0,
                  commentsCount: 0,
                ).toJson();
              },
            ),
          ],
        ),
      ),
    );
  }
}
