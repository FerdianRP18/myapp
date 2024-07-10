import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Tambahkan ini untuk menggunakan json.encode dan json.decode

class KomenFull extends StatefulWidget {
  final Map<String, dynamic> komentar;
  final bool isAdmin;

  const KomenFull({required this.komentar, required this.isAdmin});

  @override
  _KomenFullState createState() => _KomenFullState();
}

class _KomenFullState extends State<KomenFull> {
  late TextEditingController _lokasiController;
  late TextEditingController _komentarController;

  @override
  void initState() {
    super.initState();
    _lokasiController = TextEditingController(text: widget.komentar['lokasi']);
    _komentarController =
        TextEditingController(text: widget.komentar['komentar']);
  }

  @override
  void dispose() {
    _lokasiController.dispose();
    _komentarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Komentar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nama: ${widget.komentar['nama']}'),
            Text('Tanggal: ${widget.komentar['createdAt']}'),
            Text('Lokasi: ${widget.komentar['lokasi']}'),
            Text('Komentar: ${widget.komentar['komentar']}'),
            SizedBox(height: 20),
            widget.isAdmin
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _confirmDeleteKomentar(
                              widget.komentar['id'], context);
                        },
                        child: Text('Hapus Komentar'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _editKomentarDialog(context);
                        },
                        child: Text('Edit Komentar'),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteKomentar(String komentarId, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Komentar'),
          content: Text('Apakah Anda yakin ingin menghapus komentar ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteKomentar(komentarId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteKomentar(String komentarId) async {
    final url = Uri.parse(
        'https://668d45b1099db4c579f2609f.mockapi.io/ac/comments/$komentarId');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Komentar berhasil dihapus'),
        ));
        Navigator.pop(context, true);
        Navigator.pop(
            context, true); // Tambahkan ini untuk kembali ke halaman utama
      } else {
        throw Exception('Gagal menghapus komentar');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  void _editKomentarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Komentar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi'),
              ),
              TextField(
                controller: _komentarController,
                decoration: InputDecoration(labelText: 'Komentar'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                Navigator.of(context).pop();
                _editKomentar(widget.komentar['id']);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editKomentar(String komentarId) async {
    final url = Uri.parse(
        'https://668d45b1099db4c579f2609f.mockapi.io/ac/comments/$komentarId');

    final updatedKomentar = {
      'lokasi': _lokasiController.text,
      'komentar': _komentarController.text,
      'createdAt':
          widget.komentar['createdAt'], // Mempertahankan tanggal yang ada
      'nama': widget.komentar['nama'],
    };

    try {
      final response = await http.put(
        url,
        body: json.encode(updatedKomentar),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Komentar berhasil diperbarui'),
        ));
        Navigator.pop(context, true);
      } else {
        throw Exception('Gagal memperbarui komentar');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }
}
