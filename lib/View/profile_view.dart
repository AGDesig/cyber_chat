import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart'; // Import your SignInController
import 'package:social_app/Controllers/profile_controller.dart';
import 'package:social_app/utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  final SignInController _signInController = Get.find<SignInController>(); // Get the instance of SignInController
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final String currentUserUid = _signInController.currentUserUid; // Get the current user UID

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _signInController.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
        title: Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _profileController.getUserProfile(currentUserUid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User not found'));
          }

          // Cast the data to Map<String, dynamic>
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;
          final String name = userProfile['name'] ?? 'No Name'; // Handle missing data
          final String email = userProfile['email'] ?? 'No Email'; // Handle missing data
          final String profilePictureUrl = userProfile['photoUrl'] ?? ''; // Handle missing data
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profilePictureUrl.isNotEmpty
                      ? NetworkImage(profilePictureUrl)
                      : AssetImage('assets/images/placeholder.png'), // Use a placeholder image if no URL
                ),
                SizedBox(height: 20),
                Text(name, style: TextStyle(fontSize: 24)),
                Text(email, style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.editProfile);
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
