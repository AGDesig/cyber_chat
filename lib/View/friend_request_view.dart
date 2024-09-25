import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/friend_controller.dart';
import 'package:social_app/utils/app_routes.dart';
import '../Controllers/chat_controller.dart';
import '../Controllers/signin_controller.dart';
import '../model/user_model.dart';

class FriendRequestScreen extends StatelessWidget {
  final FriendController _friendController = Get.put(FriendController());
  final ChatController _chatController = Get.find<ChatController>();
  final SignInController _signInController = Get.find<SignInController>();
  final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests'),
      ),
      body: Column(
        children: [
          // Section to show the list of friends
          Text("List of friends"),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<UserModel>>(
              future: _friendController.getFriends(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No friends yet.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel user = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () async {
                          // Start chat when user is tapped
                          String chatId = await _chatController.getChatId(currentUserUid, user.uid);

                          // Navigate to the chat screen
                          Get.toNamed(
                            AppRoutes.chat.replaceAll(':chatId', chatId),
                            arguments: {
                              'chatId': chatId,
                              'currentUserUid': currentUserUid,
                              'otherUserUid': user.uid,
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          // Section to show incoming friend requests
          Expanded(
            flex: 1,
            child: FutureBuilder<List<UserModel>>(
              future: _friendController.getFriendRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No incoming friend requests.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel user = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              _friendController.acceptFriendRequest(user.uid);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              _friendController.declineFriendRequest(user.uid);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          // Section to search and send friend requests
          Expanded(
            flex: 1,
            child: FutureBuilder<List<UserModel>>(
              future: _friendController.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No users found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel user = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: () {
                          _friendController.sendFriendRequest(user.uid);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
