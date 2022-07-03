import 'package:flutter/material.dart';
import '../models/post.dart';
import './new_post_screen.dart';

class PostsScreen extends StatelessWidget {
  final List<Post> _posts;
  final Function _addPost;

  PostsScreen(this._posts, this._addPost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
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
