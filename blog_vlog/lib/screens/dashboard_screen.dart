// Class for dashboard screen

import 'package:blog_vlog/screens/view_blogpost.dart';
import 'package:blog_vlog/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseStorageServices _storageServices = FirebaseStorageServices();

  @override
  Widget build(BuildContext context) {
    final blogPostsStream = _storageServices.blogPostsStream();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff84A98C),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            debugPrint("fab clicked");
            Navigator.pushNamed(context, "/blogpost_screen");
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowBlogScreen(
                                    title: blogPostData['title'],
                                    body: blogPostData['body'])));
                      },
                      child: Card(
                        margin: EdgeInsets.all(16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[100],
                          ),
                          title: Text(blogPostData['title'] ?? 'No Title'),
                          // subtitle:
                          // Text(blogPostData['body'] ?? 'No body')
                        ),
                      ),
                    );
                  }),
            );
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Text("No data..!");
          }
        });
  }
}
