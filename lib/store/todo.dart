import 'package:flutter/foundation.dart';
import 'package:flutter_todo/common/tab_group.dart';

enum TodoStatus { completed, unCompleted }

class Todo {
  Todo({this.id, this.label, this.completed = TodoStatus.unCompleted});

  dynamic id;
  String label;
  TodoStatus completed;
}

class TodoModel with ChangeNotifier {
  int todoId = 1;

  List<Todo> todoList = [];
  TabStatus tabStatus = TabStatus.all;

  void add(Todo todo) {
    todo.id = todoId++;
    todoList.add(todo);
    notifyListeners();
  }

  void remove(dynamic id) {
    if (id == null) return;

    int todoIndex = todoList.indexWhere((todo) {
      return todo.id == id;
    });

    todoList.removeAt(todoIndex);
    notifyListeners();
  }

  void clear() {
    todoList = todoList
        .where((todo) => todo.completed == TodoStatus.unCompleted)
        .toList();
    notifyListeners();
  }

  void updateTodoStatus(int todoId, TodoStatus status) {
    Todo targetTodo = todoList.firstWhere((todo) => todo.id == todoId);

    if (targetTodo.id != null) {
      targetTodo.completed = status;
      print(targetTodo);
      notifyListeners();
    }
  }

  void updateTabStatus(TabStatus status) {
    tabStatus = status;
    notifyListeners();
  }
}
