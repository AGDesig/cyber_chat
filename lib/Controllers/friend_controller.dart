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

  // Fetch all users except the current user
  Future<List<UserModel>> getAllUsers() async {
    String currentUserUid = _signInController.currentUserUid;

    final querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromDocument(doc.data() as Map<String, dynamic>))
        .where((user) => user.uid != currentUserUid)
        .toList();
  }

  // Fetch all friend requests received by the current user
  Future<List<UserModel>> getFriendRequests() async {
    String currentUserUid = _signInController.currentUserUid;

    final userSnapshot = await _firestore.collection('users').doc(currentUserUid).get();
    final userData = UserModel.fromDocument(userSnapshot.data() as Map<String, dynamic>);

    List<UserModel> friendRequests = [];
    for (String uid in userData.friendRequests) {
      final requestSnapshot = await _firestore.collection('users').doc(uid).get();
      friendRequests.add(UserModel.fromDocument(requestSnapshot.data() as Map<String, dynamic>));
    }
    return friendRequests;
  }

  // Fetch all friends of the current user
  Future<List<UserModel>> getFriends() async {
    String currentUserUid = _signInController.currentUserUid;

    final userSnapshot = await _firestore.collection('users').doc(currentUserUid).get();
    final userData = UserModel.fromDocument(userSnapshot.data() as Map<String, dynamic>);

    List<UserModel> friends = [];
    for (String uid in userData.friends) {
      final friendSnapshot = await _firestore.collection('users').doc(uid).get();
      friends.add(UserModel.fromDocument(friendSnapshot.data() as Map<String, dynamic>));
    }
    return friends;
  }
}
