import 'package:flutter/material.dart';
import 'package:amttm/app/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'are men talking too much?',
      home: Home(),
    );
  }
}
