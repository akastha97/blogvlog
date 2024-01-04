// ignore_for_file: prefer_const_constructors

import 'package:blog_vlog/screens/dashboard_screen.dart';
import 'package:blog_vlog/screens/home_screen.dart';
import 'package:blog_vlog/screens/login_screen.dart';
import 'package:blog_vlog/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      routes: {
        "/home_screen": (context) => HomeScreen(),
        "/login_screen": (context) => LoginScreen(),
        "/signup_screen": (context) => SignupScreen(),
        "/dashboard_screen": (context) => DashboardScreen(),
      },
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
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
