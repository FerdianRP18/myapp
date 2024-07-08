import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'create.dart'; // Import halaman Create
import 'edit_delete.dart'; // Import halaman EEditDelete

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CRUD WITH HTTP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataList = [];
  var loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var url = Uri.parse('https://demo.resthapi.com/group');
    var response = await get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        loading = false;
        dataList = jsonResponse['docs'];
        if (kDebugMode) {
          print('Number of groups: $jsonResponse.');
        }
      });
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
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Create(),
            ),
          );
          if (result == 'true') {
            setState(() {
              loading = true;
              getData();
            });
          }
        },
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EEditDelete(
                            data: dataList[i],
                          ),
                        ),
                      );
                      if (result == 'true') {
                        setState(() {
                          loading = true;
                          getData();
                        });
                      }
                    },
                    child: Card(
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${dataList[i]['name']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Text(
                              'Description: ${dataList[i]['description']}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}