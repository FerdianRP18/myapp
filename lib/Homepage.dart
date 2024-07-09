import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CounterProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('State Management Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: counterProvider.counter,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: counterProvider.incrementCounter,
                child: Text('Tambah'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: counterProvider.decrementCounter,
                child: Text('Kurang'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
