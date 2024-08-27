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
        title: Text('메인 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationPopup();
              },
            );
          },
          child: Text('팝업 열기'),
        ),
      ),
    );
  }
}

class ConfirmationPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 텍스트 위젯1
          Text(
            '확인하시겠습니까?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          // 박스1
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // row1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('금', style: TextStyle(fontSize: 18)),
                    Text('100,000원', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 10),
                // row2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('금', style: TextStyle(fontSize: 18)),
                    Text('십만원', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                  _showPasswordPad(context); // 비밀번호 숫자패드 팝업 열기
                },
                child: Text('네'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                },
                child: Text('아니오'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 비밀번호 숫자패드 팝업을 여는 함수
  void _showPasswordPad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PasswordPadPopup();
      },
    );
  }
}

class PasswordPadPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('비밀번호를 입력하세요.', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          // 여기에서 비밀번호 숫자 패드 구현
          // 예시로 숫자 버튼 1~9를 배치할 수 있습니다.
        ],
      ),
    );
  }
}
