import 'package:flutter/material.dart';
import 'user_list.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON List',
      home: UserListPage(),
    );
  }
}
