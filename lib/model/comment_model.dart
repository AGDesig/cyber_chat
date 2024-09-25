import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String postId;
  String userId;
  String content;
  DateTime timestamp;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.timestamp,
  });

  // Method to convert from Firestore DocumentSnapshot
  factory Comment.fromDocument(Map<String, dynamic> data, String documentId) {
    return Comment(
      id: documentId,
      postId: data['postId'],
      userId: data['userId'],
      content: data['content'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'content': content,
      'timestamp': Timestamp.now(),
    };
  }
}
