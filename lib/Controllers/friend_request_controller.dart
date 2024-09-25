import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FriendRequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send Friend Request
  Future<void> sendFriendRequest(String recipientUid) async {
    String senderUid = _auth.currentUser!.uid;

    await _firestore.collection('friend_requests').doc(recipientUid)
        .collection('requests').doc(senderUid).set({
      'senderUid': senderUid,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Accept Friend Request
  Future<void> acceptFriendRequest(String senderUid) async {
    String recipientUid = _auth.currentUser!.uid;

    // Update request status to accepted
    await _firestore.collection('friend_requests').doc(recipientUid)
        .collection('requests').doc(senderUid).update({
      'status': 'accepted',
    });

    // Add both users as friends
    await _firestore.collection('users').doc(recipientUid)
        .collection('friends').doc(senderUid).set({});

    await _firestore.collection('users').doc(senderUid)
        .collection('friends').doc(recipientUid).set({});
  }

  // Reject Friend Request
  Future<void> rejectFriendRequest(String senderUid) async {
    String recipientUid = _auth.currentUser!.uid;
    await _firestore.collection('friend_requests').doc(recipientUid)
        .collection('requests').doc(senderUid).delete();
  }

  // Get List of Friend Requests
  Stream<List<DocumentSnapshot>> getFriendRequests() {
    String recipientUid = _auth.currentUser!.uid;

    return _firestore.collection('friend_requests').doc(recipientUid)
        .collection('requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
