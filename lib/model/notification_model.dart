class NotificationModel {
  String id;
  String userId;
  String postId;
  String type; // "like" or "comment"
  DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'postId': postId,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory NotificationModel.fromDocument(Map<String, dynamic> data, String documentId) {
    return NotificationModel(
      id: documentId,
      userId: data['userId'],
      postId: data['postId'],
      type: data['type'],
      timestamp: DateTime.parse(data['timestamp']),
    );
  }
}
