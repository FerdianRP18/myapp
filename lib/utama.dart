import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Utama extends StatefulWidget {
  @override
  _UtamaState createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  String _nama = '';
  List<dynamic> _komentar = [];

  @override
  void initState() {
    super.initState();
    _loadNama();
    _loadKomentar();
  }

  Future<void> _loadNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? 'Pengguna';
    });
  }

  Future<void> _loadKomentar() async {
    final url = Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/comments');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _komentar = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal memuat komentar'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Selamat datang, $_nama!', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/komen');
            },
            child: Text('Tambah Komentar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _komentar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_komentar[index]['lokasi']),
                  subtitle: Text(_komentar[index]['komentar']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
