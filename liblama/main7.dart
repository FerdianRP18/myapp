import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'register.dart';
import 'home.dart';
import 'shared_preferences_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(role: null), // Just for initialization
        '/login': (context) => LoginPage(),
      },
    );
  }
}
