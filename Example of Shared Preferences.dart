import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  void loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => counter = prefs.getInt('counter') ?? 0);
  }

  void incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => counter++);
    await prefs.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Shared Preferences")),
        body: Center(child: Text("Counter: $counter")),
        floatingActionButton: FloatingActionButton(
          onPressed: incrementCounter,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
