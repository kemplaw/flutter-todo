import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tab_group.dart';
import 'package:flutter_todo/store/todo.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
      ),
      body: Center(
        child: TodoApp(),
      ),
    );
  }
}

class TodoApp extends StatelessWidget {
  Todo todoMaker(String label) {
    return Todo(id: 1, label: label);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TabGroup(
          onPressed: (TabStatus id) {
            print(id);
          },
        ),
        Consumer<TodoModel>(
          builder: (BuildContext context, todoModel, _) {
            return TextField(
              decoration: InputDecoration(hintText: '请输入你的待办事项'),
              onChanged: (v) {
                todoModel.add(todoMaker(v));
              },
            );
          },
        ),
        Consumer<TodoModel>(
          builder: (ctx, todoModel, _) {
            return ListView(
              children: todoModel.todoList
                  .map((todo) => Text(todo.label) as List<Widget>),
            );
          },
        )
      ],
    );
  }
}
