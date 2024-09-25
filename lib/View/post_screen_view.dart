import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/post_controller.dart';
import 'package:social_app/controllers/comment_controller.dart';
import 'package:social_app/controllers/like_controller.dart';
import 'package:social_app/model/comment_model.dart';
import 'package:social_app/model/post_model.dart'; // Import LikeController

class PostScreen extends StatelessWidget {
  final PostController _postController = Get.put(PostController());
  final CommentController _commentController = Get.put(CommentController());
  final LikeController _likeController = Get.put(LikeController()); // Add LikeController
  final TextEditingController contentController = TextEditingController();
  final TextEditingController mediaUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _postController.createPost(contentController.text, mediaUrlController.text);
                    contentController.clear();
                    mediaUrlController.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Post>>(
              stream: _postController.getPosts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Post post = posts[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(post.content),
                            subtitle: Text(post.userId),
                          ),
                          post.mediaUrl.isNotEmpty
                              ? Image.network(post.mediaUrl, height: 100, width: 100, fit: BoxFit.cover)
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<List<Like>>(
                                stream: _likeController.getLikes(post.id),
                                builder: (context, likeSnapshot) {
                                  if (!likeSnapshot.hasData) {
                                    return Text('0 Likes');
                                  }

                                  var likes = likeSnapshot.data!;
                                  return Text('${likes.length} Likes');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.thumb_up),
                                onPressed: () async {
                                  await _likeController.likePost(post.id);

                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Add a comment...',
                                      border: OutlineInputBorder(),
                                    ),
                                    onSubmitted: (value) {
                                      _commentController.createComment(post.id, value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<List<Comment>>(
                            stream: _commentController.getComments(post.id),
                            builder: (context, commentSnapshot) {
                              if (!commentSnapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              var comments = commentSnapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  Comment comment = comments[index];
                                  return ListTile(
                                    title: Text(comment.content),
                                    subtitle: Text(comment.userId),
                                  );
                                },
                              );
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
        ],
      ),
    );
  }
}
