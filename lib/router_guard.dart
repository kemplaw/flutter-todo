import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeRoute(),
      },
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        bool isSignIn = true;

        print(settings.name);

        switch (settings.name) {
          case 'auth_route':
            builder = (context) => isSignIn ? AuthRoute() : LoginRoute();
            break;
          default:
            throw new Exception('wrong route name');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: GestureDetector(
        child: Center(
          child: Text('home screen'),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'auth_route');
        },
      ),
    );
  }
}

class AuthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Text('auth screen'),
      ),
    );
  }
}

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login '),
      ),
      body: Center(
        child: Text('need login'),
      ),
    );
  }
}
