import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Fetch list of friends for the current user
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getFriends(String currentUserUid) async {
    // Get the current user's data
    final userSnapshot = await _firestore.collection('users').doc(currentUserUid).get();
    final userData = userSnapshot.data();

    // If there are no friends, return an empty list
    if (userData == null || userData['friends'] == null) {
      return [];
    }

    // Get the list of friends' UIDs
    final List<String> friendUids = List<String>.from(userData['friends']);

    // Fetch all friends' documents at once using 'where' clause
    final friendSnapshots = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: friendUids)
        .get();

    return friendSnapshots.docs;  // Return the list of friend documents
  }



  // Fetch list of users
  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection("users").snapshots();
  }

  // Send message to the Firestore chat collection
  Future<void> sendMessage(String chatId, String message, String senderUid) async {
    try {
      await _firestore.collection('chats').doc(chatId).collection('messages').add({
        'message': message,
        'senderUid': senderUid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  // Get messages from Firestore in real-time
  Stream<List<QueryDocumentSnapshot>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  // Get chatId by comparing both UIDs
  Future<String> getChatId(String currentUserUid, String otherUserUid) async {
    final chatRef = _firestore.collection('chats');
    final querySnapshot = await chatRef
        .where('users', arrayContains: currentUserUid)
        .get();

    // Check if a chat exists between the two users
    for (var doc in querySnapshot.docs) {
      if (doc['users'].contains(otherUserUid)) {
        return doc.id;  // Existing chat found
      }
    }

    // If no existing chat is found, create a new one
    final newChat = await chatRef.add({
      'users': [currentUserUid, otherUserUid],
      'createdAt': FieldValue.serverTimestamp(),
    });

    return newChat.id;
  }
}
