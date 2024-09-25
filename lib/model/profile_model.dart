class UserProfile {
  String uid;
  String name;
  String email;
  String profilePictureUrl;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  // Convert from Firestore Document to UserProfile
  factory UserProfile.fromFirestore(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      profilePictureUrl: data['profilePictureUrl'],
    );
  }
}
