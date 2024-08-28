import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_keypad_dialog.dart';


class HowMuchScreen extends StatefulWidget {
  final String initialMoney = "입력해 주세요.";

  @override
  _HowMuchScreenState createState() => _HowMuchScreenState();
}

class _HowMuchScreenState extends State<HowMuchScreen> {
  String _balance = ''; // 잔고(숫자) API에서 가져온 값을 저장
  String _enteredMoney = ''; // 보낼 돈을 저장해놓는 변수
  
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
      _balance = "100000"; // API로부터 받은 잔고
    });
  }
///////////////////////////////////////////////////////////////////
  // 숫자 팝업창
  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HowMuchKeypadDialog(
          onNumberEntered: (enteredNumber) {
            setState(() {
              _enteredMoney = enteredNumber; // 입력된 계좌 번호 저장
            });
          },
        );
      },
    );
  }
////////////////////////////////////////////////////////////////
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
        title: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child : Text('돌아가기'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Text('얼마를 보낼까요?'),
          Center(
            child: Container(
              child: Column(
                children: [
                  Text('남은 돈'),
                  Text('1,500,000 원'),
                  Text('보낼 돈'),
                  TextButton(
                    onPressed: _showInputDialog,
                      child: Text(_enteredMoney.isEmpty ? widget.initialMoney : _enteredMoney))
                ],
              )
            )
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
