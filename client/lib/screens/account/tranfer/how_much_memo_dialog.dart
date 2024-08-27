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
        title: Text('입력 팝업 예제'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return WhatToWritePopup();
              },
            );
          },
          child: Text('팝업 열기'),
        ),
      ),
    );
  }
}

class WhatToWritePopup extends StatefulWidget {
  @override
  _WhatToWritePopupState createState() => _WhatToWritePopupState();
}

class _WhatToWritePopupState extends State<WhatToWritePopup> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Text : 무엇을 적을까요?
          Text(
            '무엇을 적을까요?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // 2. Container1(회색)
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // a. Text : 적을 내용
                Text(
                  '적을 내용',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                // b. TextButton : 여기를 눌러주세요
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode()); // 키보드 숨기기
                    Future.delayed(Duration(milliseconds: 100), () {
                      FocusScope.of(context).requestFocus(FocusNode()); // 키보드 보이기
                    });
                  },
                  child: Text(
                    '여기를 눌러주세요',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // 3. TextButton1 : 완료
          // 4. TextButton2 : 취소
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendMoneyScreen(), // send_money_screen 페이지로 이동
                    ),
                  );
                },
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendMoneySuccessScreen(), // send_money_success 페이지로 이동
                    ),
                  );
                },
                child: Text(
                  '취소',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// send_money_screen 페이지 예시
class SendMoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('송금 화면'),
      ),
      body: Center(
        child: Text('여기에 송금 화면이 표시됩니다.'),
      ),
    );
  }
}

// send_money_success 페이지 예시
class SendMoneySuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('송금 성공'),
      ),
      body: Center(
        child: Text('송금이 성공적으로 완료되었습니다.'),
      ),
    );
  }
}
