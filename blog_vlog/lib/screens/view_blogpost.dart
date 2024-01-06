import 'package:flutter/material.dart';

class ShowBlogScreen extends StatefulWidget {
  final String title;
  final String body;

  ShowBlogScreen({super.key, required this.title, required this.body});

  @override
  State<ShowBlogScreen> createState() => _ShowBlogScreenState();
}

class _ShowBlogScreenState extends State<ShowBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Color(0xff84A98C),
          elevation: 10,
          title: Image.asset(
            "lib/assets/logo-2.png",
            fit: BoxFit.fill,
            height: 50,
            width: 160,
          ),
          centerTitle: true,
        ),
        // backgroundColor: Color),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("lib/assets/photo-2.png")),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.body,
                    style: TextStyle(
                      fontSize: 16,
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
