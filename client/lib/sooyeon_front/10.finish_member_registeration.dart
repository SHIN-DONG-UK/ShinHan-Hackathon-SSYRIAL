import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member Registration',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFFCE4EC), // Light pink background
      ),
      home: FinishMemberRegistrationScreen(),
    );
  }
}

class FinishMemberRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 등록 완료'),
        backgroundColor: Colors.pink[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/characters.png', // Make sure to add this image to your assets
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              '회원 등록이 완료되었어요!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(
                '마치기',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                // 마치기 버튼 기능 구현
                print('Registration finished');
              },
            ),
          ],
        ),
      ),
    );
  }
}