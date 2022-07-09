import './task.dart';

class TodoCard {
  String title;
  List<Task> tasks;

  TodoCard(this.title, [this.tasks = const <Task>[]]);
}
