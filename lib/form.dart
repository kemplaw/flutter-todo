import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

bool isSignIn = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/':
            builder = (context) => isSignIn ? HomeScreen() : AuthRoute();
            break;
          default:
            throw new Exception('error route');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home screen'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('home screen'),
          onPressed: () {
            Navigator.pushNamed(context, 'auth_route');
          },
        ),
      ),
    );
  }
}

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() {
    return _AuthRouteState();
  }
}

class _AuthRouteState extends State<AuthRoute> {
  final TextEditingController _usernameInputController =
      TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'username',
                  hintText: 'enter username',
                  prefixIcon: Icon(Icons.person),
                ),
                autofocus: true,
                controller: _usernameInputController,
                validator: (v) {
                  return v.trim().length > 0 ? null : '请填写用户名';
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'enter password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                controller: _passwordInputController,
                validator: (v) {
                  return v.trim().length < 5 ? '密码不能小于5位' : null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('login'),
                          onPressed: () {
                            // FormState form = Form.of(context); // 此处的 context 为 AuthRoute 的context，并不存在 Form，所以需要使用 GlobalKey
                            FormState form = _formKey.currentState;
                            bool isValid = form.validate();

                            if (isValid) {
                              form.save();
                              final formValue = {
                                'username': _usernameInputController.text,
                                'password': _passwordInputController.text
                              };

                              print(formValue);
                            }
                          },
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
