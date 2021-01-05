import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CounterModel(),
      )
    ],
    child: MyApp(),
  ));
}

// 定义数据模型
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app bar'),
      ),
      body: Center(
        child: Column(
          children: [
            Counter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.select((CounterModel c) => c.increment),
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.watch<CounterModel>().count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
