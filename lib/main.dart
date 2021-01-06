import 'package:flutter/material.dart';
import 'package:flutter_todo/auth_screen.dart';
import 'package:flutter_todo/store/auth.dart';
import 'package:flutter_todo/todo_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    create: (_) => AuthModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'auth': (context) => AuthScreen()},
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/':
            builder = (context) {
              return context.select((AuthModel auth) => auth.isAuth)
                  ? AuthScreen()
                  : TodoScreen();
            };
            break;
          default:
            throw new Exception('navigator error');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
