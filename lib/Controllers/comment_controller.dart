import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/notification_controller.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/model/comment_model.dart';

class CommentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignInController _signInController = Get.find<SignInController>();
  final NotificationController _notificationController = Get.put(NotificationController());


  // Create a new comment
  Future<void> createComment(String postId, String content) async {
    String currentUserUid = _signInController.currentUserUid;
    Comment comment = Comment(
      id: '',
      postId: postId,
      userId: currentUserUid,
      content: content,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('comments').add(comment.toMap());
    // Inside the createComment method
    await _notificationController.createNotification(postId, 'comment'); // Call this when a comment is added

  }

  // Fetch comments for a specific post
  Stream<List<Comment>> getComments(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Comment.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
