import 'package:aegis_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class WelcomeScreen extends StatelessWidget
{
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
            ),
            Text('Please choose an username.'),
            TextField(controller: _controller),
            ElevatedButton(
                onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(User(_controller.text))));
                },
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                child: Text('Let\'s go!')
            )
          ],
        ),
      )
    );
  }
}