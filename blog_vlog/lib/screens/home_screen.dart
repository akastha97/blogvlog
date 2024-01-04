// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
            
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login_screen");
                },
                icon: Icon(
                  Icons.arrow_circle_right,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
