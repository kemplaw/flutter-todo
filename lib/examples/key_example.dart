import 'package:flutter/material.dart';

void main() {
  runApp(Screen());
}

class StatefullContainer extends StatefulWidget {
  StatefullContainer({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  _StatefullContainer createState() {
    print('new widget');

    return _StatefullContainer(color: color);
  }
}

class _StatefullContainer extends State<StatefullContainer> {
  _StatefullContainer({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Widget> widgets = [
    Padding(
      key: Key('1'),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: StatefullContainer(color: Colors.black54),
    ),
    Padding(
      key: Key('2'),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: StatefullContainer(color: Colors.amber),
    )
  ];

  switchWidget() {
    setState(() {
      widgets.insert(0, widgets.removeAt(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            children: widgets,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: switchWidget,
          child: Icon(Icons.undo),
        ),
      ),
    );
  }
}
