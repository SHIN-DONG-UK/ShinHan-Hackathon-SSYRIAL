import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_keypad_password_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_success_dialog.dart';

class ConfirmationPopup extends StatelessWidget {
  final String titleText = '이 금액이 맞나요?';
  final String Password = '123';
  String enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 텍스트 위젯1
          Text(
            titleText,
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
        return HowMuchKeypadPasswordDialog();
      },
    );
  }

  void _showSuccessDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return TransferSuccessPopup();
        });
  }

  // 오류 다이얼로그를 보여주는 함수
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('비밀번호가 틀립니다. 다시 시도해주세요.', style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 오류 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}