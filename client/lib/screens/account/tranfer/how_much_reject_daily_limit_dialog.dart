import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('금액 초과 예제'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AmountExceededPopup();
              },
            );
          },
          child: Text('팝업 열기'),
        ),
      ),
    );
  }
}

class AmountExceededPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Text : 오늘 보낼 수 있는 금액을 넘겼어요
          Text(
            '오늘 보낼 수 있는 금액을 넘겼어요',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // 2. Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // a. Row1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text : 금
                  Text(
                    '금',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Text : 50,000 원
                  Text(
                    '50,000 원',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // b. Row2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text : 금
                  Text(
                    '금',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Text : 오만원
                  Text(
                    '오만원',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          // 3. TextButton : 돌아가기
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 현재 팝업 닫기
            },
            child: Text(
              '돌아가기',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
