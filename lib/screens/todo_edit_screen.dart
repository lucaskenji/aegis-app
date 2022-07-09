import 'package:flutter/material.dart';
import '../models/todo_card.dart';
import '../models/task.dart';

class TodoEditScreen extends StatefulWidget{
  final TodoCard _todoCard;
  final Function _saveTodoCard;
  final Function _deleteTodoCard;

  TodoEditScreen(this._todoCard, this._saveTodoCard, this._deleteTodoCard);

  @override
  State<TodoEditScreen> createState() => TodoEditScreenState();
}

class TodoEditScreenState extends State<TodoEditScreen>{
  final TextEditingController _checklistController = TextEditingController();
  late TextEditingController _titleController = TextEditingController(text: widget._todoCard.title);
  late List<Task> _tasks = _getTasks();

  List<Task> _getTasks(){
    // Copy each object to avoid saving a task's state when leaving without pressing the Save button
    return widget._todoCard.tasks.map((task) {
      return Task(task.description, task.isDone);
    }).toList();
  }

  void _addTask(Task newTask) {
    setState(() => _tasks.add(newTask));
    _checklistController.clear();
  }
  
  void _removeTask(Task task){
    setState(() => _tasks.remove(task));
  }

  void _moveTask(int originalIndex, int newIndex){
    setState(() {
      Task task = _tasks.elementAt(originalIndex);
      _tasks.removeAt(originalIndex);

      // Because a task is missing, when moving to last position the newIndex can be out of bounds
      if (newIndex > _tasks.length){
        newIndex = _tasks.length;
      }

      _tasks.insert(newIndex, task);
    });
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
                    'Edit card',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ]
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Color(0xffd3d9e3),
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.all(8)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _checklistController,
                      decoration: InputDecoration(
                          labelText: 'Checklist',
                          fillColor: Color(0xffd3d9e3),
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          _addTask(Task(_checklistController.text, false));
                        },
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(minimumSize: Size(24, 56)),
                    )
                  ),
                ],
              )
            ),
            Expanded(
                child: ReorderableListView(
                  onReorder: _moveTask,
                  shrinkWrap: true,
                  children: _tasks.map((task) {
                    return CheckboxListTile(
                        key: Key(task.description),
                        title: Text(task.description),
                        value: task.isDone,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (checked) {
                          setState(() {
                            task.isDone = checked ?? false;
                          });
                        },
                        secondary: IconButton(
                          onPressed: () => _removeTask(task),
                          icon: Icon(Icons.delete),
                        ),
                    );
                  }).toList(),
                )
            ),
            ElevatedButton(
                onPressed: () {
                  widget._deleteTodoCard(widget._todoCard);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    primary: Colors.red
                ),
                child: Text('Delete'),
            ),
            ElevatedButton(
                onPressed: () {
                  widget._saveTodoCard(widget._todoCard, _titleController.text, _tasks);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}