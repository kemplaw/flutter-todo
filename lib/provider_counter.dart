import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider<CounterModel>(
    create: (_) => CounterModel(),
    child: Counter(),
  ));
}

class CounterModel with ChangeNotifier {
  int count = 1;

  increment() {
    count++;
    notifyListeners();
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'counter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('counter demo'),
        ),
        body: Consumer<CounterModel>(
          builder: (_, counter, __) {
            return Text('${counter.count}');
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'increment',
          onPressed: () {
            context.read<CounterModel>().increment();
          },
        ),
      ),
    );
  }
}
