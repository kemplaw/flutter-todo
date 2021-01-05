import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'named router',
      initialRoute: '/',
      routes: {
        'new_route': (context) =>
            NewRoute(routerParams: ModalRoute.of(context).settings.arguments),
        '/': (context) => MyHomePage()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home screen'),
      ),
      body: Center(
        child: Text('home page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right),
        onPressed: () {
          Navigator.pushNamed(context, 'new_route', arguments: 'hello');
        },
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  NewRoute({this.routerParams});

  final routerParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new route page'),
      ),
      body: Center(
        child: Text('new route page, params: $routerParams'),
      ),
    );
  }
}
