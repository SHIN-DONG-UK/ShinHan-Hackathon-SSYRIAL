import 'package:flutter/material.dart';
import 'package:ssyrial/config/hive_config.dart';
import 'package:ssyrial/screens/account/create/create_account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
