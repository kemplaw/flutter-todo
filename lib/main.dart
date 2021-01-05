import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('json serializable'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('get'),
            onPressed: () async {
              try {
                Response res = await http.get('http://192.168.0.113:3000');
              } catch (e) {}
            },
          ),
        ),
      ),
    );
  }
}
