// ignore_for_file: prefer_const_constructors

// Class for Homescreen/ Get started screen

import 'package:blog_vlog/custom_components/custom_button.dart';
import 'package:blog_vlog/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/bg-final.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                "Welcome to BlogVlog!\nYour daily dose of content",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CustomButton(
                  buttonText: "Get Started!",
                  onPressed: () {
                    Get.toNamed(AppRoutes.loginScreenRoute);
                  }),
            ),
          ],
        ),
      ]),
    ));
  }
}
