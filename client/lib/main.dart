import 'package:flutter/material.dart';
import 'package:ssyrial/config/hive_config.dart';
import 'package:ssyrial/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO:하이브 주석
  // Initialize Hive
//  await HiveConfig.init();

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
      home: HomeScreen(),
    );
  }
}
