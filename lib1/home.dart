import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart'; // renamed to avoid conflict
import 'comment_form.dart'; // renamed to avoid conflict

class HomePage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              String? userId = snapshot.data!.getString('userId');
              String? nama = snapshot.data!.getString('nama');

              return Column(
                children: [
                  Text('User ID: $userId'),
                  Text('Nama: $nama'),
                ],
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/comment_form');
            },
            child: Text('Add Comment'),
          ),
          Expanded(
            child: FutureBuilder(
              future: http.get(
                  Uri.parse('https://668d45b1099db4c579f2609f.mockapi.io/ac/comments')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text('No comments found');
                }
                final comments = json.decode(snapshot.data.body);
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Card(
                      child: ListTile(
                        title: Text(comment['nama']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location: ${comment['lokasi']}'),
                            Text('Comment: ${comment['komentar']}'),
                            Text('Date: ${comment['createdAt']}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
