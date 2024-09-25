import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String userId;
  String content; // This can be text, image URL, or video URL
  String mediaUrl; // URL for images or videos
  DateTime timestamp;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.mediaUrl,
    required this.timestamp,
  });

  // Method to convert from Firestore DocumentSnapshot
  factory Post.fromDocument(Map<String, dynamic> data, String documentId) {
    return Post(
      id: documentId,
      userId: data['userId'],
      content: data['content'],
      mediaUrl: data['mediaUrl'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'mediaUrl': mediaUrl,
      'timestamp': Timestamp.now(),
    };
  }
}

class Like {
  String id;
  String postId;
  String userId;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
  });

  // Method to convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
    };
  }

  // Method to convert from Firestore DocumentSnapshot
  factory Like.fromDocument(Map<String, dynamic> data, String documentId) {
    return Like(
      id: documentId,
      postId: data['postId'],
      userId: data['userId'],
    );
  }
}
