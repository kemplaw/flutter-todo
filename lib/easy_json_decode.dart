import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  getDataFromHttp() async {
    try {
      http.Response res = await http.get('http://192.168.0.113:3000');

      Map userMap = jsonDecode(res.body);
      var user = User.fromJson(userMap);

      print('username: ${user.name}');
      print('email: ${user.email}');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('http demo'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('get'),
            onPressed: getDataFromHttp,
          ),
        ),
      ),
    );
  }
}
