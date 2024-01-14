import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';

class LoginPreferences {
  late SharedPreferences preferences;
  late bool loginVal;

  // Method to initialize preferences
  Future<void> initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  // To save the login value to shared preferences.
  void saveLoginVal(bool loggedIn) async {
    await initializePreferences();
    preferences.setBool('isLoggedIn', loggedIn);
  }

  // To get the login value from the shared preferences.
  Future<bool?> getLoginValue() async {
    await initializePreferences();
    bool loginVal = preferences.getBool('isLoggedIn') ?? false;
    debugPrint("Login value is : $loginVal");
    return loginVal;
  }

  // To check if the user has logged in or not and navigate accordingly.
  void navigateToScreen() async {
    bool? logged = await getLoginValue();

    if (logged!) {
      // If logged in, navigate to the dashboard screen.
      Get.offNamed(AppRoutes.dashboardScreenRoute);
    } else {
      // If not logged in, navigate to the login screen.
      Get.offNamed(AppRoutes.loginScreenRoute);
    }
  }
}
