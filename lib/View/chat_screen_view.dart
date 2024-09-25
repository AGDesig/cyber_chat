import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/utils/app_routes.dart';

import '../Controllers/chat_controller.dart';
import '../Controllers/signin_controller.dart';

class ChatScreenView extends StatelessWidget {
  ChatScreenView({super.key});
  final ChatController _chatController = Get.find<ChatController>();
  final SignInController _signInController = Get.find<SignInController>();
  final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Chat Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          future: _chatController.getFriends(currentUserUid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final friends = snapshot.data!;

            if (friends.isEmpty) {
              return Center(child: Text('No friends found.'));
            }

            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                var userDoc = friends[index].data(); // Access data here
                String userName = userDoc['name'] ?? 'Unknown User';
                String userUid = userDoc['uid'] ?? '';
                String userPhoto = userDoc['photoUrl'] ?? '';

                return ListTile(
                  leading: Image.network(userPhoto),
                  title: Text(userName),
                  onTap: () async {
                    // Start chat when user is tapped
                    String chatId = await _chatController.getChatId(currentUserUid, userUid);

                    // Navigate to the chat screen
                    Get.toNamed(
                      AppRoutes.chat.replaceAll(':chatId', chatId),
                      arguments: {
                        'chatId': chatId,
                        'currentUserUid': currentUserUid,
                        'otherUserUid': userUid,
                      },
                    );
                  },
                );
              },
            );
          },
        ),


      ),
    );
  }
}
