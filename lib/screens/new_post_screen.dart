import 'package:flutter/material.dart';
import '../models/post.dart';

class NewPostScreen extends StatelessWidget
{
  final Function _addPost;
  final TextEditingController _textFieldController = TextEditingController();


  NewPostScreen(this._addPost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(
                  labelText: 'New post...',
                  fillColor: Color(0xffd3d9e3),
                  filled: true
                ),
            ),
            ElevatedButton(
                onPressed: () {
                  _addPost(Post(_textFieldController.text));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                child: const Text('POST')
            )
          ],
        )
      )
    );
  }
}