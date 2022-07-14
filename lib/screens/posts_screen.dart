import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/user.dart';
import './new_post_screen.dart';

class PostsScreen extends StatefulWidget{
  final User _user;
  final List<User> _usersFollowing;
  final bool _isCurrentUser;
  final Function _addPost;

  PostsScreen(
      this._user,
      this._usersFollowing,
      this._isCurrentUser,
      this._addPost
  );

  @override
  State<PostsScreen> createState() => PostsScreenState();
}

class PostsScreenState extends State<PostsScreen> {
  late int indexUserFollowing = widget._usersFollowing.indexOf(widget._user);

  void _updatePostList(Post newPost){
    // Because PostsScreen isn't present in HomeScreen's build method, tell it to render again
    setState(() => widget._addPost(newPost));
  }

  void _updateFollowingList(){
    setState(() {
      if (indexUserFollowing == -1) {
        widget._usersFollowing.add(widget._user);
      } else {
        widget._usersFollowing.removeAt(indexUserFollowing);
      }

      // Updates to re-render button and make follow/unfollow work on next tap
      indexUserFollowing = widget._usersFollowing.indexOf(widget._user);
    });
  }

  Widget _renderButton(){
    if (widget._isCurrentUser) {
      return ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen(_updatePostList))),
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
        child: const Icon(Icons.add),
      );
    } else {
      return ElevatedButton(
        onPressed: _updateFollowingList,
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
        child: indexUserFollowing == -1 ? const Text('Follow') : const Text('Unfollow'),
      );
    }
  }

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
                        '${widget._user.username}\'s posts',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                ),
              ),
              _renderButton(),
              ListView(
                shrinkWrap: true,
                children: widget._user.posts.map((post) {
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
