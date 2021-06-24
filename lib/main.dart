import 'package:flutter/material.dart';
import 'package:hushangbang/pages/home.dart';
import 'package:hushangbang/pages/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '沪上帮',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => Home(),
        'login' : (context) => Login()
      },
    );
  }
}

void main() => runApp(App());
