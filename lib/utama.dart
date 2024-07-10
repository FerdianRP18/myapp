import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'komenfull.dart';

class Utama extends StatefulWidget {
  @override
  _UtamaState createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  String _nama = '';
  bool _isAdmin = false;
  List _komentarList = [];

  @override
  void initState() {
    super.initState();
    _loadNama();
    _fetchKomentar();
  }

  Future<void> _loadNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? 'Pengguna';
      _isAdmin = prefs.getBool('isAdmin') ?? false;
    });
  }

  Future<void> _fetchKomentar() async {
    final url = Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/comments');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _komentarList = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal mengambil komentar'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/masuk');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Selamat datang, $_nama'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/komen');
                if (result == true) {
                  _fetchKomentar();
                }
              },
              child: Text('Tambah Komentar'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _komentarList.length,
                itemBuilder: (context, index) {
                  final komentar = _komentarList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Nama: ${komentar['nama']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal: ${komentar['createdAt']}'),
                          Text('Lokasi: ${komentar['lokasi']}'),
                          Text('Komentar: ${komentar['komentar']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KomenFull(
                                komentar: komentar,
                                isAdmin: _isAdmin,
                              ),
                            ),
                          );
                          if (result == true) {
                            _fetchKomentar(); // Perbarui daftar komentar setelah kembali dari KomenFull
                          }
                        },
                        child: Text('Lihat'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
