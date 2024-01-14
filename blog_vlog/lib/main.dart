// ignore_for_file: prefer_const_constructors

import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/routes/app_screens.dart';
import 'package:blog_vlog/util/login_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.homeScreenRoute,
      getPages: AppScreens().screens,
      debugShowCheckedModeBanner: false,
      title: 'Blog Vlog',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LoginPreferences services = LoginPreferences();

  @override
  void initState() {
    super.initState();
    services.navigateToScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
