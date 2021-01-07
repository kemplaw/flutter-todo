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
      body: TodoApp(),
    );
  }
}

class TodoApp extends StatelessWidget {
  Todo todoModelBuilder(String label) {
    return Todo(label: label, completed: TodoStatus.unCompleted);
  }

  List<Todo> getFilteredTodoList(
    List<Todo> todoList,
    TabStatus checkedTabStatus,
  ) {
    if (todoList.isEmpty) return [];

    List<Todo> resultTodoList;

    if (checkedTabStatus == TabStatus.all) {
      resultTodoList = todoList;
    } else if (checkedTabStatus == TabStatus.completed) {
      resultTodoList = todoList
          .where((todo) => todo.completed == TodoStatus.completed)
          .toList();
    } else {
      resultTodoList = todoList
          .where((todo) => todo.completed == TodoStatus.unCompleted)
          .toList();
    }

    return resultTodoList.isEmpty ? [] : resultTodoList;
  }

  void handleChangeTodoStatus(
      {int id, bool checkValue, TodoStatus status, @required Function update}) {
    TodoStatus targetStatus =
        checkValue ? TodoStatus.completed : TodoStatus.unCompleted;
    update(id, targetStatus);
  }

  Widget _todoWiget(
    Todo todo,
    Function update,
    Function remove,
  ) {
    return Row(
      key: ValueKey(todo.id),
      children: [
        Checkbox(
          value: todo.completed == TodoStatus.completed,
          onChanged: (v) {
            handleChangeTodoStatus(
              id: todo.id,
              checkValue: v,
              status: todo.completed,
              update: update,
            );
          },
        ),
        Expanded(
          flex: 1,
          child: Text(todo.label),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            remove(todo.id);
          },
        )
      ],
    );
  }

  Widget _todoListWidget(
    List<Todo> todoList,
    Function update,
    Function remove,
  ) {
    Widget emptyText = Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: Text(
          '暂无数据',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );

    if (todoList.isEmpty) {
      return emptyText;
    }

    List<Widget> newTodoList =
        todoList.map((todo) => _todoWiget(todo, update, remove)).toList();

    return ListView(children: newTodoList.isEmpty ? emptyText : newTodoList);
  }

  Widget _todoHelper(List<Todo> todoList, Function clear) {
    int leftTodoItemLength = todoList.isEmpty
        ? 0
        : todoList
            .where((todo) => todo.completed == TodoStatus.unCompleted)
            .length;

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$leftTodoItemLength items left',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          OutlineButton(
            child: Text('clear completed todo'),
            onPressed: () {
              clear();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _todoFieldController = TextEditingController();

    return Consumer<TodoModel>(
      builder: (_, todoModel, __) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            children: [
              TabGroup(
                checked: todoModel.tabStatus,
                onPressed: (tabStatus) {
                  todoModel.updateTabStatus(tabStatus);
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: _todoFieldController,
                  decoration: InputDecoration(hintText: '请输入待办事项'),
                  onSubmitted: (v) {
                    if (v.trim().isEmpty) return;

                    Todo newTodo = todoModelBuilder(v);
                    todoModel.add(newTodo);
                    _todoFieldController.text = '';
                  },
                ),
              ),
              Expanded(
                child: _todoListWidget(
                  getFilteredTodoList(todoModel.todoList, todoModel.tabStatus),
                  todoModel.updateTodoStatus,
                  todoModel.remove,
                ),
              ),
              _todoHelper(todoModel.todoList, todoModel.clear)
            ],
          ),
        );
      },
    );
  }
}
