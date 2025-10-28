import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(content, textAlign: TextAlign.center)));
}

Future<File?> pickImage(BuildContext context, ImageSource imageSource) async {
  File? image;
  try {
    if (imageSource == ImageSource.gallery) {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } else if (imageSource == ImageSource.camera) {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showSnackBar(context, e.toString());
  }
  return image;
}
