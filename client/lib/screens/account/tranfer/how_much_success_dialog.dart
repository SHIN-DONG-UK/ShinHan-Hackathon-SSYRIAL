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
        title: Text('송금 완료'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TransferSuccessPopup();
              },
            );
          },
          child: Text('송금 완료 팝업 열기'),
        ),
      ),
    );
  }
}

class TransferSuccessPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Text : 성공적으로 보냈어요
          Text(
            '성공적으로 보냈어요',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // 2. Container(회색)
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text : 보낸 돈
                    Text(
                      '보낸 돈',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Container(흰색) : 보낸 돈 금액
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '50,000원',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Column2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text : 받으신 분
                    Text(
                      '받으신 분',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Container(흰색) : 받으신 분 이름
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '김신한',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Container(흰색) : 받으신 분 계좌번호
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '신한 121-141-121453',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // 3. Text : 보낸 이유를 적을까요?
          Text(
            '보낸 이유를 적을까요?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),

          // 4. TextButton1 : 네
          // 5. TextButton2 : 아니오
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                  _showReasonPopup(context); // 보낸 이유 팝업 열기
                },
                child: Text(
                  '네',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
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
                  '아니오',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 보낸 이유 팝업을 여는 함수
  void _showReasonPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('보낸 이유를 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
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
