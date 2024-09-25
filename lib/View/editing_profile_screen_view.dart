import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/profile_controller.dart';
import 'package:social_app/Controllers/signin_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final SignInController _signInController = Get.find<SignInController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String currentUserUid = _signInController.currentUserUid;

    // Initialize text controllers with existing data
    void initTextControllers() async {
      var userProfile = await _profileController.getUserProfile(currentUserUid);
      var data = userProfile.data() as Map<String, dynamic>;
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
    }

    initTextControllers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _profileController.updateProfile(
                  currentUserUid,
                  nameController.text,
                  emailController.text,
                );
                Get.back(); // Go back after saving
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
