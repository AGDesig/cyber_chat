import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/model/post_model.dart';

class PostController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignInController _signInController = Get.find<SignInController>();

  // Create a new post
  Future<void> createPost(String content, String mediaUrl) async {
    String currentUserUid = _signInController.currentUserUid;
    Post post = Post(
      id: '',
      userId: currentUserUid,
      content: content,
      mediaUrl: mediaUrl,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('posts').add(post.toMap());
  }

  // Fetch all posts
  Stream<List<Post>> getPosts() {
    return _firestore.collection('posts').orderBy('timestamp', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
