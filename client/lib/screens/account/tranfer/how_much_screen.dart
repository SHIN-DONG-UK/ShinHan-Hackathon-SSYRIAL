import 'package:flutter/material.dart';


class HowMuchScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HowMuchScreen> {
  int balance = 0; // 잔고(숫자) API에서 가져온 값을 저장
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBalance(); // 초기화시 API 호출하여 잔고를 가져옴
  }

  void _fetchBalance() async {
    // 여기에 실제 API 호출을 통해 데이터를 가져오는 로직이 들어가야 합니다.
    // 예시로 임의의 값을 설정합니다.
    setState(() {
      balance = 100000; // API로부터 받은 잔고
    });
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('보낼 돈 입력'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "보낼 돈을 입력하세요"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                // 입력된 값을 처리하는 로직 추가
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('확인'),
          content: Text('정말 보내시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                // 전송 로직 추가
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('예제 화면'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // 돌아가기 버튼 -> 스크린 팝
            },
            child: Text('돌아가기'),
          ),
          Text('얼마'),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('남은돈'),
                    Text(balance.toString()), // 잔고(숫자)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('보낼돈'),
                    ElevatedButton(
                      onPressed: _showInputDialog, // 숫자를 입력할 수 있는 새로운 팝업창 생성
                      child: Text('입력받기'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: false, // 숨겨져 있는 버튼
            child: ElevatedButton(
              onPressed: _showConfirmationDialog, // 한 번 더 확인하는 팝업 생성
              child: Text('보내기'),
            ),
          ),
        ],
      ),
    );
  }
}
