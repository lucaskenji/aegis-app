import 'package:flutter/material.dart';
import '../screens/posts_screen.dart';
import '../models/user.dart';

class FollowingScreen extends StatelessWidget {
  final List<User> _users;
  final Function _addPost;

  FollowingScreen(this._users, this._addPost);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
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
                    'Following',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ]
              ),
            ),
            Expanded(
              child: ListView(
                children: _users.map((user) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return PostsScreen(user, _users, false, _addPost);
                      }));
                    },
                    child: Container(
                      color: Color(0xffd3d9e3),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        user.username,
                        style: TextStyle(fontSize: 20)
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      )
    );
  }
}