import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ShowBlogScreen extends StatefulWidget {
  dynamic argsData;

  ShowBlogScreen({super.key, required this.argsData});

  @override
  State<ShowBlogScreen> createState() => _ShowBlogScreenState();
}

class _ShowBlogScreenState extends State<ShowBlogScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.argsData = Get.arguments;
  }

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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.argsData[2] ?? "https://picsum.photos/200/",
                          // fit: BoxFit.contain,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.argsData[0] ?? "",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.argsData[1] ?? "",
                    style: const TextStyle(
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
