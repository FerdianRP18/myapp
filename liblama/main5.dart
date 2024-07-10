import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nama = "";
  String jenisKelamin = "";
  int umur = 0;
  String alamat = "";
  String hobi = "";

  TextEditingController namaController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController hobiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Shared Preferences'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // Input nama
          TextField(
            controller: namaController,
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 4)),
          // Input jenis kelamin
          TextField(
            controller: jenisKelaminController,
            decoration: InputDecoration(
              labelText: "Jenis Kelamin (L/P)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 4)),
          // Input umur
          TextField(
            controller: umurController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Umur",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 4)),
          // Input alamat
          TextField(
            controller: alamatController,
            decoration: InputDecoration(
              labelText: "Alamat",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 4)),
          // Input hobi
          TextField(
            controller: hobiController,
            decoration: InputDecoration(
              labelText: "Hobi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          // Button untuk menyimpan data ke SharedPreferences melalui setIntoSharedPreferences()
          ElevatedButton(
            child: Text("Set"),
            onPressed: () {
              setIntoSharedPreferences();
            },
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          // Tombol untuk memanggil getFromSharedPreferences() untuk menampilkan data
          ElevatedButton(
            child: Text("Get"),
            onPressed: () {
              getFromSharedPreferences();
            },
          ),
        ],
      ),
    );
  }

  // Metode untuk menyimpan data ke SharedPreferences
  void setIntoSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nama", namaController.text);
    await prefs.setString("jenisKelamin", jenisKelaminController.text);
    await prefs.setInt("umur", int.parse(umurController.text));
    await prefs.setString("alamat", alamatController.text);
    await prefs.setString("hobi", hobiController.text);
  }

  // Metode untuk mengambil data dari SharedPreferences dan menampilkan dalam pop-up
  void getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString("nama") ?? "";
      jenisKelamin = prefs.getString("jenisKelamin") ?? "";
      umur = prefs.getInt("umur") ?? 0;
      alamat = prefs.getString("alamat") ?? "";
      hobi = prefs.getString("hobi") ?? "";
    });
    // Menampilkan data dalam pop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informasi Anda"),
          content: Text(
              "Nama: $nama\nJenis Kelamin: $jenisKelamin\nUmur: $umur\nAlamat: $alamat\nHobi: $hobi"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
