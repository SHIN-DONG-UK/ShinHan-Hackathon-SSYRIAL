import 'package:flutter/material.dart';
import 'package:ssyrial/config/tts_config.dart';

class test1 extends StatefulWidget {
  @override
  _test1State createState() => _test1State();
}

class _test1State extends State<test1> {
  final TTSConfig ttsConfig = TTSConfig();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '테스트화면',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
