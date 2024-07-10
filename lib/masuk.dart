import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Masuk extends StatefulWidget {
  @override
  _MasukState createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email == 'admin' && password == 'admin') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'nama', 'Admin'); // Simpan nama admin ke SharedPreferences
      await prefs.setBool('isAdmin', true); // Tandai pengguna sebagai admin

      Navigator.pushReplacementNamed(context, '/utama');
    } else {
      // Jika bukan admin, lakukan pengecekan menggunakan API
      final url =
          Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/user');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List users = json.decode(response.body);

          final user = users.firstWhere(
            (user) => user['email'] == email && user['password'] == password,
            orElse: () => null,
          );

          if (user != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('nama', user['nama']);

            Navigator.pushReplacementNamed(context, '/utama');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Email atau password salah'),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Gagal terhubung ke server'),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TanyaTukang'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Gambar di tengah-tengah kolom
            Image.asset(
              'assets/Grup.png', // Ubah lokasi dan nama gambar sesuai kebutuhan Anda
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            // Input Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10.0),
            // Input Password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            // Tombol Login
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            // Tombol untuk menuju halaman pendaftaran
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/daftar');
              },
              child: Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}
