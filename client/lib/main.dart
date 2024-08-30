import 'package:flutter/material.dart';
import 'test_home.dart';

void main() {
  runApp(SSYRIALApp());
}

class SSYRIALApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSYRIAL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestHomeScreen(),
    );
  }
}
