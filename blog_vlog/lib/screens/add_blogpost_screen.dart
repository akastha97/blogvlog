// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_vlog/custom_components/custom_button.dart';
import 'package:blog_vlog/custom_components/custom_textfield.dart';
import 'package:blog_vlog/models/blogpost_model.dart';
import 'package:blog_vlog/routes/app_routes.dart';
import 'package:blog_vlog/services/attachment_service.dart';
import 'package:blog_vlog/services/storage_services.dart';
import 'package:blog_vlog/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPostScreen extends StatefulWidget {
  const BlogPostScreen({super.key, this.callBack});
  final Function(String)? callBack;
  @override
  State<BlogPostScreen> createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  File? selectedImage;
  AttachmentServices attachmentServices = AttachmentServices();
  FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
  BlogPostModel? postModel;
  late final String? imageUrl;

  // Method to open the gallery service
  Future<void> openGallery() async {
    File? image = await attachmentServices.openGallery();
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  void initState() {
    firebaseStorageServices.initializeStorageRefs();
    super.initState();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, top: 20),
              child: selectedImage != null
                  ? Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                            width: double.infinity,
                            child: Image.file(
                              selectedImage!,
                            )),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        debugPrint("gallery icon clicked");
                        openGallery();
                      },
                      child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.green[100],
                          child: Icon(
                            Icons.collections,
                            color: Colors.black,
                          )),
                    ),
            ),
            CustomTextField(
              maxlines: null,
              suffix: SizedBox(),
              label: "Title",
              hint: "Give a title",
              obscure: false,
              controller: _titleController,
            ),
            CustomTextField(
                maxlines: null,
                suffix: SizedBox(),
                label: "Body",
                hint: "Describe",
                obscure: false,
                controller: _bodyController),
            CustomButton(
                buttonText: "Publish",
                onPressed: () async {
                  AppConstants().displayLoading(context);

                  try {
                    await firebaseStorageServices
                        .uploadFile(selectedImage?.path ?? '');

                    postModel = BlogPostModel(_titleController.text,
                        _bodyController.text, selectedImage?.path ?? '');

                    debugPrint("After updating postModel: $postModel");

                    await Future.delayed(Duration(seconds: 2));
                    print(
                        "Firebase Storage reference: ${firebaseStorageServices}");

                    postModel!.imagePath =
                        await firebaseStorageServices.getDownloadUrl();

                    await firebaseStorageServices
                        .addBlogPost(postModel!); // title body

                    AppConstants().displaySnackBar("Post added successfully");

                    debugPrint("Image path: ${postModel!.imagePath}");

                    Get.offAndToNamed(AppRoutes.dashboardScreenRoute);
                  } catch (error) {
                    print("Error retrieving download URL: $error");
                    print("Error handling post creation: $error");
                  }
                }),
            SizedBox(height: 50)
          ],
        ),
      ),
    ));
  }
}
