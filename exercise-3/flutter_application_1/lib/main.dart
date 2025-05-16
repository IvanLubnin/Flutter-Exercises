import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Counter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('counters').doc('myCounter').get();
      if (doc.exists) {
        setState(() {
          _counter = doc.get('value') ?? 0;
        });
      }
    } catch (e) {
      print("Error loading counter: $e");
    }
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    try {
      await _firestore.collection('counters').doc('myCounter').set({'value': _counter});
    } catch (e) {
      print("Error loading counter: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Counter')),
      body: Center(
        child: Text(
          'Counter: $_counter',
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
