import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitsEditScreen extends StatefulWidget{
  Habit _habit;
  Function _saveHabit;
  Function _deleteHabit;

  HabitsEditScreen(this._habit, this._saveHabit, this._deleteHabit);

  @override
  State<HabitsEditScreen> createState() => HabitsEditScreenState();
}

class HabitsEditScreenState extends State<HabitsEditScreen>{
  late TextEditingController _titleController = TextEditingController(text: widget._habit.title);
  late Habit _habit = Habit(widget._habit.title, widget._habit.counter);

  void _updateCounter(int value){
    // Doesn't allow negative numbers
    value = value < 0 ? 0 : value;
    setState(() => _habit.counter = value);
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
                    'Edit habit',
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
            Padding(
              padding: EdgeInsets.only(
                  left: 5,
                  top: 20,
                  bottom: 20
              ),
              child: Text('Current streak'),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => _updateCounter(_habit.counter - 1),
                      icon: Icon(Icons.minimize)
                  ),
                  Column(
                    children: [
                      Text(
                        _habit.counter.toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('DAYS'),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () => _updateCounter(_habit.counter + 1),
                      icon: Icon(Icons.add)
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget._deleteHabit(widget._habit);
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
                _habit.title = _titleController.text;
                widget._saveHabit(widget._habit, _habit);
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