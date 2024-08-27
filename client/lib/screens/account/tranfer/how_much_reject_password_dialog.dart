import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HowMuchScreen(),
    );
  }
}

class HowMuchScreen extends StatefulWidget {
  @override
  _HowMuchScreenState createState() => _HowMuchScreenState();
}

class _HowMuchScreenState extends State<HowMuchScreen> {
  // Controller for the amount input
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('금액 입력'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TextButton1 : 돌아가기
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 현재 화면 닫기
              },
              child: Text(
                '돌아가기',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),

            // 2. Text1 : 얼마를 보낼까요?
            Text(
              '얼마를 보낼까요?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 3. Container1(회색)
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // a. Container(회색) - 잔고
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '잔고',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),

                  // b. Container1(흰색) - 1,500,000 원
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1,500,000 원',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),

                  // c. Text : 보낼 돈
                  Text(
                    '보낼 돈',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // d. Container2(흰색) - 입력해 주세요.
                  GestureDetector(
                    onTap: () {
                      _showAmountInputDialog(context);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '입력해 주세요.',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 4. TextButton2 : 보내기
            TextButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: Text(
                '보내기',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the amount input dialog
  void _showAmountInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('금액 입력'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '금액을 입력하세요',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('확인'),
          content: Text('정말로 이 금액을 송금하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // Add the action to perform on confirmation
                Navigator.of(context).pop(); // Close the confirmation dialog
                Navigator.of(context).pop(); // Optionally close the current screen
                // Perform the actual send action here
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
