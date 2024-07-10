import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class Komen extends StatefulWidget {
  @override
  _KomenState createState() => _KomenState();
}

class _KomenState extends State<Komen> {
  final _lokasiController = TextEditingController();
  final _komentarController = TextEditingController();
  String _nama = '';

  @override
  void initState() {
    super.initState();
    _loadNama();
  }

  Future<void> _loadNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? 'Pengguna';
    });
  }

  void _submitKomentar() async {
    final lokasi = _lokasiController.text;
    final komentar = _komentarController.text;
    final createdAt = DateTime.now().toIso8601String();

    // Validasi input
    if (lokasi.isEmpty || komentar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Semua kolom harus diisi'),
      ));
      return;
    }

    // API endpoint untuk mengirim komentar
    final url = Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/comments');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama': _nama,
          'lokasi': lokasi,
          'komentar': komentar,
          'createdAt': createdAt,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Komentar berhasil dikirim'),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal mengirim komentar'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Komentar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextField(
              controller: _komentarController,
              decoration: InputDecoration(labelText: 'Komentar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitKomentar,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
