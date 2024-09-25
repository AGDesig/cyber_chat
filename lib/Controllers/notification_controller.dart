import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';

import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignInController _signInController = Get.find<SignInController>();

  // Create a new notification
  Future<void> createNotification(String postId, String type) async {
    String currentUserUid = _signInController.currentUserUid;
    NotificationModel notification = NotificationModel(
      id: '',
      userId: currentUserUid,
      postId: postId,
      type: type,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('notifications').add(notification.toMap());
  }

  // Fetch notifications for the current user
  Stream<List<NotificationModel>> getUserNotifications() {
    String currentUserUid = _signInController.currentUserUid;
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: currentUserUid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
