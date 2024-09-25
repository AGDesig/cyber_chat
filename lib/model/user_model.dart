class UserModel {
  String uid;
  String name;
  String email;
  String photoUrl;
  List<String> friends; // List of friends' UIDs
  List<String> friendRequests; // List of UIDs who sent friend requests

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.friends = const [],
    this.friendRequests = const [],
  });

  // Method to convert from Firestore DocumentSnapshot
  factory UserModel.fromDocument(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      friends: List<String>.from(data['friends'] ?? []),
      friendRequests: List<String>.from(data['friendRequests'] ?? []),
    );
  }

  // Method to convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'friends': friends,
      'friendRequests': friendRequests,
    };
  }
}
