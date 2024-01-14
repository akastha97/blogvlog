import 'dart:io';

import 'package:blog_vlog/models/blogpost_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageServices {
  late Reference uploadImageRef;
  late String imageID;

  final CollectionReference blogPosts =
      FirebaseFirestore.instance.collection("blogposts");

  // To initialize Firebase Storage references
  // call this method in the UI to initialize the firebase storage
  Future<void> initializeStorageRefs() async {
    Reference storageRootRef = FirebaseStorage.instance.ref();
    Reference imagesFolderRef = storageRootRef.child("images");
    imageID = DateTime.now().millisecondsSinceEpoch.toString();
    uploadImageRef = imagesFolderRef.child(imageID);
  }

  // To add and save the new blog post to Firebase
  Future<DocumentReference> addBlogPost(BlogPostModel model) async {
    Map<String, dynamic> data = {
      'title': model.title,
      'body': model.body,
    };

    if (model.imagePath != null && model.imagePath!.isNotEmpty) {
      data['imageUrl'] = model.imagePath;
    }

    return blogPosts.add(data);
  }

  // Future<DocumentReference> addBlogPost(BlogPostModel model) async {
  //   return blogPosts.add({
  //     'title': model.title,
  //     'body': model.body,
  //     'imageUrl': model.imagePath
  //   });
  // }

  // To get and read the existing blog posts from Firebase
  Stream<QuerySnapshot> getBlogPostsStream() {
    final blogPostsStream = blogPosts.snapshots();
    return blogPostsStream;
  }

  // To upload file to the firebase
  // Call this when posting a blog
  Future<void> uploadFile(String? path) async {
    try {
      if (path != null && File(path).existsSync()) {
        await uploadImageRef.putFile(File(path!));
      } else {
        print("File does not exist. Skipping upload.");
      }
    } catch (error) {
      debugPrint("Error with uploading: $error");
    }
  }

  // To get the url of the image uploaded
  Future<String?> getDownloadUrl() async {
    String? imageUrl = await uploadImageRef.getDownloadURL();
    return imageUrl;
  }
}
