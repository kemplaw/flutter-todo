/// 登录授权页面

import 'package:flutter/material.dart';
import 'package:flutter_todo/store/auth.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: AuthForm(),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() {
    return _AuthFormState();
  }
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(child: Builder(
      builder: (formContext) {
        return ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: '用户名', hintText: '请输入用户名'),
              controller: _usernameController,
              validator: (v) {
                return v.length > 0 ? null : '请输入用户名';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '密码', hintText: '请输入密码'),
              controller: _passwordController,
              obscureText: true,
              obscuringCharacter: '*',
              validator: (v) {
                return v.length > 5 ? null : '密码最短为6位';
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Builder(
                        builder: (BuildContext context) {
                          print('button build');

                          return RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text('登录'),
                            onPressed: () {
                              FormState formState = Form.of(formContext);
                              bool isValid = formState.validate();
                              final updateAuthStatus = formContext
                                  .read<AuthModel>()
                                  .updateAuthStatus;

                              if (isValid) {
                                updateAuthStatus(false);
                                Navigator.of(context).pushReplacementNamed('/');
                              } else {
                                updateAuthStatus(true);
                              }
                            },
                          );
                        },
                      )),
                )
              ],
            )
          ],
        );
      },
    ));
  }
}
