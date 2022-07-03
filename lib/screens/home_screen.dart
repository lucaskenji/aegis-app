import 'package:flutter/material.dart';
import '../screens/posts_screen.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => MyAppState();
}

class MyAppState extends State<HomeScreen>
{
  final _posts = <Post>[];

  void _addPost(Post newPost){
    setState(() => _posts.add(newPost));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aegis',
        home: PostsScreen(_posts, _addPost)
    );
  }
}