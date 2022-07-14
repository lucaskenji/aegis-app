import 'package:aegis_app/screens/habits_screen.dart';
import 'package:aegis_app/screens/posts_screen.dart';
import 'package:aegis_app/screens/search_screen.dart';
import 'package:aegis_app/screens/todo_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../models/post.dart';
import '../models/todo_card.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
{
  var _todoCards = <TodoCard>[];
  var _habits = <Habit>[];
  late List<User> _users = _populateUsers();

  void _addPost(Post newPost){
    setState(() => widget._user.posts.add(newPost));
  }

  void _addTodoCard(TodoCard newTodoCard){
    setState(() => _todoCards.add(newTodoCard));
  }

  void _addHabit(Habit newHabit){
    setState(() => _habits.add(newHabit));
  }

  List<User> _populateUsers(){
    // Using this temporarily while memory is being used as a database.
    return <User>[
      User('Anna'),
      User('Bob'),
      User('Charlie'),
      User('David'),
      User('Emmanuel')
    ];
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
                  return PostsScreen(widget._user, _addPost);
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
                  return SearchScreen(_users);
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