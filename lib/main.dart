import 'package:flutter/material.dart';
import 'masuk.dart';
import 'daftar.dart';
import 'utama.dart';
import 'komen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Komentar Sederhana',
      initialRoute: '/',
      routes: {
        '/': (context) => Masuk(),
        '/daftar': (context) => Daftar(),
        '/utama': (context) => Utama(),
        '/komen': (context) => Komen(),
      },
    );
  }
}
