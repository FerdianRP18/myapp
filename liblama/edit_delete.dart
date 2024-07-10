import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EEditDelete extends StatefulWidget {
  const EEditDelete({super.key, this.data});
  final data;

  @override
  State<EEditDelete> createState() => _EEditDeleteState();
}

class _EEditDeleteState extends State<EEditDelete> {
  TextEditingController nameGroupTxt = TextEditingController();
  TextEditingController descriptionGroupTxt = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameGroupTxt.text = widget.data['name'];
    descriptionGroupTxt.text = widget.data['description'];
  }

  editData() async {
    var url = Uri.parse('https://demo.resthapi.com/group/${widget.data['_id']}');
    var posBody = {
      "name": nameGroupTxt.text,
      "description": descriptionGroupTxt.text
    };
    var response = await put(
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

  deleteData() async {
    var url = Uri.parse('https://demo.resthapi.com/group/${widget.data['_id']}');
    var response = await delete(url);
    if (response.statusCode == 204) {
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
        title: const Text('Edit Delete'),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  onPressed: () {
                    editData();
                  },
                ),
                const SizedBox(width: 10.0),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}