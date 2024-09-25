import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/notification_controller.dart';
import 'package:social_app/Controllers/signin_controller.dart';

import '../model/post_model.dart';

class LikeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignInController _signInController = Get.find<SignInController>();
  final NotificationController _notificationController = Get.put(NotificationController());

  // Like a post
  Future<void> likePost(String postId) async {
    String currentUserUid = _signInController.currentUserUid;

    // Check if the user has already liked the post
    final likeRef = _firestore.collection('likes').where('postId', isEqualTo: postId).where('userId', isEqualTo: currentUserUid);
    final likeSnapshot = await likeRef.get();

    if (likeSnapshot.docs.isEmpty) {
      // User hasn't liked the post, so add a new like
      Like like = Like(id: '', postId: postId, userId: currentUserUid);
      await _firestore.collection('likes').add(like.toMap());
      // Inside the likePost method
      await _notificationController.createNotification(postId, 'like'); // Call this when a post is liked

    } else {
      // User has already liked the post, so remove the like
      for (var doc in likeSnapshot.docs) {
        await _firestore.collection('likes').doc(doc.id).delete();
      }
    }

  }

  // Fetch likes for a specific post
  Stream<List<Like>> getLikes(String postId) {
    return _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Like.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Check if a user has liked a specific post
  Future<bool> hasLikedPost(String postId) async {
    String currentUserUid = _signInController.currentUserUid;
    final likeRef = _firestore.collection('likes').where('postId', isEqualTo: postId).where('userId', isEqualTo: currentUserUid);
    final likeSnapshot = await likeRef.get();
    return likeSnapshot.docs.isNotEmpty;
  }
}
