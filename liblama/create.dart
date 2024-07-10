import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController nameGroupTxt = TextEditingController();
  TextEditingController descriptionGroupTxt = TextEditingController();

  createData() async {
    var url = Uri.parse('https://demo.resthapi.com/group');
    var posBody = [
      {
        "name": nameGroupTxt.text,
        "description": descriptionGroupTxt.text
      }
    ];
    var response = await post(
      url,
      body: jsonEncode(posBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pop('true');
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: nameGroupTxt,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Name Group"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: descriptionGroupTxt,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Description Group"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: const Text(
                'Simpan',
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                createData();
              },
            ),
          ),
        ],
      ),
    );
  }
}