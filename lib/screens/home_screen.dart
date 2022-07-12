import 'package:aegis_app/screens/habits_screen.dart';
import 'package:aegis_app/screens/posts_screen.dart';
import 'package:aegis_app/screens/search_screen.dart';
import 'package:aegis_app/screens/todo_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../models/post.dart';
import '../models/todo_card.dart';

class HomeScreen extends StatefulWidget {
  final String _username;

  HomeScreen(this._username);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
{
  var _posts = <Post>[];
  var _todoCards = <TodoCard>[];
  var _habits = <Habit>[];

  void _addPost(Post newPost){
    setState(() => _posts.add(newPost));
  }

  void _addTodoCard(TodoCard newTodoCard){
    setState(() => _todoCards.add(newTodoCard));
  }

  void _addHabit(Habit newHabit){
    setState(() => _habits.add(newHabit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: const Text(
                    'Menu',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PostsScreen(_posts, _addPost, widget._username);
                })),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    alignment: Alignment.centerLeft
                ),
                child: Text('Profile'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TodoListScreen(_todoCards, _addTodoCard);
                })),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    alignment: Alignment.centerLeft
                ),
                child: Text('To-do List'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HabitsScreen(_habits, _addHabit);
                })),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    alignment: Alignment.centerLeft
                ),
                child: Text('Habit Tracker'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                })),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    alignment: Alignment.centerLeft
                ),
                child: Text('Search users'),
              )
            ],
          )
      )
    );
  }
}