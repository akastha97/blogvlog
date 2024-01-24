// Class for dashboard screen

import 'package:blog_vlog/services/storage_services.dart';
import 'package:blog_vlog/util/consts.dart';
import 'package:blog_vlog/util/login_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  String? path;
  DashboardScreen({super.key, this.path});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseStorageServices storageServices = FirebaseStorageServices();
  // final AccountServices accountServices = AccountServices();
  final LoginPreferences preferences = LoginPreferences();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blogPostsStream = storageServices.getBlogPostsStream();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  AppConstants().displayLoading(context);
                  Get.offAndToNamed(AppRoutes.loginScreenRoute);
                  preferences.saveLoginVal(false);
                },
                icon: Icon(Icons.logout_outlined))
          ],
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
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
        // backgroundColor: Color(0xff84A98C),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            debugPrint("fab clicked");
            await Get.toNamed(AppRoutes.addBlogScreenRoute);
          },
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              displayBlogsListView(blogPostsStream),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> displayBlogsListView(
      Stream<QuerySnapshot<Object?>> blogPostsStream) {
    return StreamBuilder<QuerySnapshot>(
        stream: blogPostsStream,
        builder: (context, snapshot) {
          print("Current path: $widget.path");
          if (snapshot.hasData) {
            List blogPostsList = snapshot.data!.docs;
            return Expanded(
              child: ListView.builder(
                  itemCount: blogPostsList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = blogPostsList[index];
                    Map<String, dynamic> blogPostData =
                        document.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        // navigate to the blog screen
                        Get.toNamed("/viewblog_screen", arguments: [
                          blogPostData['title'],
                          blogPostData['body'],
                          blogPostData['imageUrl']
                        ]);
                      },
                      child: Container(
                        color: Colors.green[100],
                        child: Card(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 10),
                          child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.green[100],
                                  backgroundImage: NetworkImage(
                                    blogPostData['imageUrl'] ??
                                        "https://picsum.photos/200/300",
                                  )),
                              title: Text(blogPostData['title'] ?? 'No Title'),
                              subtitle: Text(
                                blogPostData['body'] ?? 'No body',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              )),
                        ),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Text(
              "No data..!",
              style: TextStyle(color: Colors.white),
            );
          }
        });
  }
}
