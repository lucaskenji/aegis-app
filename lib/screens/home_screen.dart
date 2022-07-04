import 'package:flutter/material.dart';
import '../screens/posts_screen.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  final String _username;

  HomeScreen(this._username);

  @override
  State<HomeScreen> createState() => MyAppState(_username);
}

class MyAppState extends State<HomeScreen>
{
  final String _username;
  final _posts = <Post>[];

  MyAppState(this._username);

  void _addPost(Post newPost){
    setState(() => _posts.add(newPost));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aegis',
        home: PostsScreen(_posts, _addPost, _username)
    );
  }
}