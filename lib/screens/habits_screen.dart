import 'package:aegis_app/screens/habits_edit_screen.dart';
import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitsScreen extends StatefulWidget{
  final List<Habit> _habits;
  final Function _addHabit;

  HabitsScreen(
      this._habits,
      this._addHabit,
  );

  @override
  State<HabitsScreen> createState() => HabitsScreenState();
}

class HabitsScreenState extends State<HabitsScreen> {
  final String defaultHabitName = 'New habit';

  void _updateHabitList(Habit newHabit){
    // Add a number to the name to make it easier to distinguish new cards
    int numberSuffix = 1;

    while (widget._habits.any((habit) => habit.title == newHabit.title)){
      newHabit.title = '${defaultHabitName} (${numberSuffix})';
      numberSuffix++;
    }

    // Because TodoListScreen isn't present in HomeScreen's build method, tell it to render again
    setState(() => widget._addHabit(newHabit));
  }

  void _saveHabit(Habit habitRef, Habit newHabit){
    // Saves all the copy properties to the original reference
    setState(() {
      habitRef.title = newHabit.title;
      habitRef.counter = newHabit.counter;
    });
  }

  void _deleteHabit(Habit habit){
    setState(() => widget._habits.remove(habit));
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
                        'My habits',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                ),
              ),
              ElevatedButton(
                onPressed: () => _updateHabitList(Habit(defaultHabitName)),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                child: const Icon(Icons.add),
              ),
              ListView(
                shrinkWrap: true,
                children: widget._habits.map((habit) {
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return HabitsEditScreen(habit, _saveHabit, _deleteHabit);
                    })),
                    child: Container(
                      color: Color(0xffd3d9e3),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Streak: ${habit.counter}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ),
                  );
                }).toList()
              )
            ],
          )
      ),
    );
  }
}
