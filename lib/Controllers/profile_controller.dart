import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid, String name, String profilePictureUrl) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'name': name,
        'profilePictureUrl': profilePictureUrl,
      });
      Get.snackbar('Success', 'Profile updated successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  Future<DocumentSnapshot> getUserProfile(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }
}
