// Class for dashboard screen

import 'package:blog_vlog/services/storage_services.dart';
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
  final FirebaseStorageServices _storageServices = FirebaseStorageServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blogPostsStream = _storageServices.getBlogPostsStream();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.green[100],
                                backgroundImage: NetworkImage(
                                  blogPostData['imageUrl'] ??
                                      "https://picsum.photos/200/300",
                                )),
                            title: Text(blogPostData['title'] ?? 'No Title'),
                            subtitle: Flexible(
                                child:
                                    Text(blogPostData['body'] ?? 'No body'))),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Text(
              "No data..!",
              style: TextStyle(color: Colors.white),
            );
          }
        });
  }
}
