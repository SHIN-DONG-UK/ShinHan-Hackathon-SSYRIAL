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
        title: Text('숫자 입력 팝업 예제'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NumberInputPopup();
              },
            );
          },
          child: Text('팝업 열기'),
        ),
      ),
    );
  }
}

class NumberInputPopup extends StatefulWidget {
  @override
  _NumberInputPopupState createState() => _NumberInputPopupState();
}

class _NumberInputPopupState extends State<NumberInputPopup> {
  String inputText = ''; // 박스1.텍스트 위젯에 표시될 문자열

  void _addDigit(String digit) {
    setState(() {
      inputText += digit; // 입력한 숫자를 추가
    });
  }

  void _clearText() {
    setState(() {
      inputText = ''; // 텍스트 위젯 클리어
    });
  }

  void _deleteLastCharacter() {
    setState(() {
      if (inputText.isNotEmpty) {
        inputText = inputText.substring(0, inputText.length - 1); // 마지막 글자 삭제
      }
    });
  }

  void _onCancel() {
    Navigator.of(context).pop(); // 현재 팝업이 사라지게 함
  }

  Future<void> _onComplete() async {
    // 여기에 실제 API 호출을 통해 데이터를 보내는 로직이 들어가야 합니다.
    // 예시로 API 호출을 흉내내는 딜레이를 추가했습니다.
    await Future.delayed(Duration(seconds: 1)); // 비동기 처리를 모방하기 위한 딜레이
    Navigator.of(context).pop(); // 팝업을 닫음
    _showTransferInfoPopup(); // 송금 정보 팝업을 보여줌
  }

  void _showTransferInfoPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('송금 정보가 서버에 전송되었습니다.'),
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 텍스트 위젯
          Text('숫자를 입력하세요', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          // 박스1 - 입력된 텍스트 표시
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(inputText, style: TextStyle(fontSize: 24)),
          ),
          SizedBox(height: 20),
          // 박스2 - 숫자 버튼들
          Column(
            children: [
              // row1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                ],
              ),
              // row2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                ],
              ),
              // row3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                ],
              ),
              // row4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _clearText,
                    child: Text('모두 지우기'),
                  ),
                  _buildNumberButton('0'),
                  ElevatedButton(
                    onPressed: _deleteLastCharacter,
                    child: Text('하나 지우기'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          // 박스3 - 취소 및 완료 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _onCancel,
                child: Text('취소'),
              ),
              ElevatedButton(
                onPressed: _onComplete,
                child: Text('완료'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 숫자 버튼 생성 메서드
  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _addDigit(number),
      child: Text(number),
    );
  }
}
