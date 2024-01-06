import 'package:blog_vlog/models/blogpost_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageServices {
  final CollectionReference blogPosts =
      FirebaseFirestore.instance.collection("blogposts");

  // add a new blog post
  Future<DocumentReference> addBlogPost(BlogPostModel model) async {
    return blogPosts.add({
      'title': model.title,
      'body': model.body,
      // 'imagepath': model.imagePath,
    });
  }

  // update a blog post

  // delete a blog post

  // read the existing blog posts
  Stream<QuerySnapshot> blogPostsStream() {
    final blogPostsStream =
        blogPosts.orderBy("title", descending: true).snapshots();
    blogPostsStream.listen((event) {
      print("Stream emitted data: $event");
    });
    return blogPostsStream;
  }
}
