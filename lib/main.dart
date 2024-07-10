import 'package:flutter/material.dart';
import 'masuk.dart';
import 'daftar.dart';
import 'utama.dart';
import 'komen.dart';
//import 'komenfull.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Komentar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/masuk',
      routes: {
        '/masuk': (context) => Masuk(),
        '/daftar': (context) => Daftar(),
        '/utama': (context) => Utama(),
        '/komen': (context) => Komen(),  // pastikan Komen didefinisikan
      },
    );
  }
}
