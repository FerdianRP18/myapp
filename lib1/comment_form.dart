import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  Future<void> _submitComment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id');
    if (userId != null) {
      final response = await http.post(
        Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/comments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama': prefs.getString('nama'),
          'lokasi': _locationController.text,
          'komentar': _commentController.text,
          'userId': userId,
          'createdAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit comment')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Comment')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitComment,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
