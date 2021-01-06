import 'package:flutter/foundation.dart';

enum TodoStatus { completed, unCompleted }

class Todo {
  Todo({this.id, this.label, this.completed = TodoStatus.unCompleted});

  final dynamic id;
  final String label;
  final TodoStatus completed;
}

class TodoModel with ChangeNotifier {
  List<Todo> todoList = [];

  void add(Todo todo) {
    todoList.add(todo);
    notifyListeners();
  }

  void remove(dynamic id) {
    if (!id) return;

    int todoIndex = todoList.indexWhere((todo) {
      return todo.id == id;
    });

    todoList.removeAt(todoIndex);
    notifyListeners();
  }
}
