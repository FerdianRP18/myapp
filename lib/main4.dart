import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/Homepage.dart';
import 'package:myapp/CounterProvider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}


