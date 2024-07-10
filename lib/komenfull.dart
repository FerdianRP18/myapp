import 'package:flutter/material.dart';

class KomenFull extends StatelessWidget {
  final Map komentar;

  KomenFull({required this.komentar});

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
            Text(
              'Nama: ${komentar['nama']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Tanggal: ${komentar['createdAt']}'),
            SizedBox(height: 10),
            Text('Lokasi: ${komentar['lokasi']}'),
            SizedBox(height: 10),
            Text('Komentar: ${komentar['komentar']}'),
          ],
        ),
      ),
    );
  }
}
