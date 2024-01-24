import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  // Method to display the loading indicator alert dialog
  displayLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16)),
                height: 64,
                width: 64,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )),
          );
        });
  }

  // To display the Get Snackbar
  SnackbarController displaySnackBar(String bodyText) {
    return Get.snackbar(
      padding: EdgeInsets.all(8),
      colorText: Colors.white,
      "Post",
      bodyText,
      icon: const Icon(Icons.check_circle, color: Colors.green),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
    );
  }
}
