import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import '../model/user_model.dart';

class FriendController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  final SignInController _signInController = Get.find<SignInController>();

  // Send a friend request
  Future<void> sendFriendRequest(String friendUid) async {

  // Fetch the current user's data
    final userSnapshot = await _firestore.collection('users').doc(
        currentUserUid).get();
    final userData = userSnapshot.data();

    // Check if the friendUid is already in the friends list
    if (userData != null && userData['friends'] != null) {
      List<String> friends = List<String>.from(userData['friends']);
      if (friends.contains(friendUid)) {
        Get.snackbar('Error', 'You are already friends with this user.');
        return; // Stop execution if already friends
      } else{

        // Update sender's friend request list
        await _firestore.collection('users').doc(currentUserUid).update({
          'friendRequestsSent': FieldValue.arrayUnion([friendUid]),
        });

        // Update the receiver's incoming friend request list
        await _firestore.collection('users').doc(friendUid).update({
          'friendRequests': FieldValue.arrayUnion([currentUserUid]),
        });
      }
    }
  }

  // Accept a friend request
  Future<void> acceptFriendRequest(String senderUid) async {
    String currentUserUid = _signInController.currentUserUid;

    // Add to both users' friend lists and remove the request
    await _firestore.collection('users').doc(currentUserUid).update({
      'friends': FieldValue.arrayUnion([senderUid]),
      'friendRequests': FieldValue.arrayRemove([senderUid]),
    });

    await _firestore.collection('users').doc(senderUid).update({
      'friends': FieldValue.arrayUnion([currentUserUid]),
    });
  }

  // Decline a friend request
  Future<void> declineFriendRequest(String senderUid) async {
    String currentUserUid = _signInController.currentUserUid;

    await _firestore.collection('users').doc(currentUserUid).update({
      'friendRequests': FieldValue.arrayRemove([senderUid]),
    });
  }
  // Stream to fetch all users except the current user
  Stream<List<UserModel>> getAllUsers() {
    String currentUserUid = _signInController.currentUserUid;

    return _firestore.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => UserModel.fromDocument(doc.data() as Map<String, dynamic>))
          .where((user) => user.uid != currentUserUid) // Exclude current user
          .toList();
    });
  }

  // Stream to fetch all friend requests received by the current user
  Stream<List<UserModel>> getFriendRequests() {
    String currentUserUid = _signInController.currentUserUid;

    // Listen to changes in the current user's document
    return _firestore.collection('users').doc(currentUserUid).snapshots().asyncMap((userSnapshot) async {
      final userData = userSnapshot.data();
      if (userData == null || userData['friendRequests'] == null) return [];

      List<String> requestUids = List<String>.from(userData['friendRequests']);
      List<UserModel> friendRequests = [];

      // Fetch each user who sent a friend request
      for (String uid in requestUids) {
        final requestSnapshot = await _firestore.collection('users').doc(uid).get();
        friendRequests.add(UserModel.fromDocument(requestSnapshot.data() as Map<String, dynamic>));
      }

      return friendRequests;
    });
  }

  // Stream to fetch all friends of the current user
  Stream<List<UserModel>> getFriends() {
    String currentUserUid = _signInController.currentUserUid;

    // Listen to changes in the current user's document
    return _firestore.collection('users').doc(currentUserUid).snapshots().asyncMap((userSnapshot) async {
      final userData = userSnapshot.data();
      if (userData == null || userData['friends'] == null) return [];

      List<String> friendUids = List<String>.from(userData['friends']);
      List<UserModel> friends = [];

      // Fetch each friend document
      for (String uid in friendUids) {
        final friendSnapshot = await _firestore.collection('users').doc(uid).get();
        friends.add(UserModel.fromDocument(friendSnapshot.data() as Map<String, dynamic>));
      }

      return friends;
    });
  }
}
