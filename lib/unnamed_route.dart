import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyAppHome(),
  ));
}

class MyAppHome extends StatelessWidget {
  navigateToNewPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return NewRoute('任意参数');
    })).then((res) {
      print('pop param: $res');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home screen'),
      ),
      body: Center(
        child: Text('home screen'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pages),
        onPressed: () {
          navigateToNewPage(context);
        },
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  NewRoute(this.params);

  final String params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new route screen'),
      ),
      body: Center(
        child: Text('this is new route screen $params'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_left),
        onPressed: () {
          Navigator.pop(context, 'any param');
        },
      ),
    );
  }
}
