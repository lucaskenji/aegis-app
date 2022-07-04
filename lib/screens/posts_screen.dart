import 'package:flutter/material.dart';
import '../models/post.dart';
import './new_post_screen.dart';

class PostsScreen extends StatelessWidget {
  final List<Post> _posts;
  final Function _addPost;
  final String _username;

  PostsScreen(this._posts, this._addPost, this._username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        '${_username}\'s posts',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen(_addPost)));
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                child: const Icon(Icons.add),
              ),
              ListView(
                shrinkWrap: true,
                children: _posts.map((post) {
                  return Container(
                    color: Color(0xffd3d9e3),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                        post.text,
                        style: TextStyle(fontSize: 20)
                    )
                  );
                }).toList(),
              )
            ],
          )
      ),
    );
  }
}
