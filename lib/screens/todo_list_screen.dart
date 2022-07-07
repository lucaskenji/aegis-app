import 'package:aegis_app/screens/todo_edit_screen.dart';
import 'package:flutter/material.dart';
import '../models/todo_card.dart';
import '../models/task.dart';

class TodoListScreen extends StatefulWidget {
  final List<TodoCard> _todoCards;
  final Function _addTodoCard;

  TodoListScreen(this._todoCards, this._addTodoCard);
  
  @override
  State<TodoListScreen> createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen>{
  void _updateTodoList(TodoCard newTodoCard){
    // Because TodoListScreen isn't present in HomeScreen's build method, tell it to render again
    setState(() => widget._addTodoCard(newTodoCard));
  }

  void _saveTodoCard(TodoCard todoCard, String title, List<Task> tasks){
    setState(() {
      todoCard.title = title;
      todoCard.tasks = tasks;
    });
  }

  void _deleteTodoCard(TodoCard todoCard){
    setState(() => widget._todoCards.remove(todoCard));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    'My to-do list',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ]
            ),
            ElevatedButton(
                onPressed: () => _updateTodoList(TodoCard('New to-do card')),
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                child: Icon(Icons.add)
            ),
            ListView(
              shrinkWrap: true,
              children: widget._todoCards.map((todoCard) {
                return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return TodoEditScreen(todoCard, _saveTodoCard, _deleteTodoCard);
                    })),
                  child: Text(todoCard.title),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}