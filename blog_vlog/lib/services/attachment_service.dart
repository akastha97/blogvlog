// All the services related to attachments are defined here.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentServices {
  // open gallery method
  Future<File?> openGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) {
        return null;
      } else {
        return File(returnedImage.path);
      }
    } on PlatformException catch (error) {
      debugPrint('Failed to pick image: $error');
    }
  }
}
