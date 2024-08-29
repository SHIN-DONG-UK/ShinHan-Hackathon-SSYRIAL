import 'package:flutter/material.dart';
import 'package:ssyrial/screens/guide/function_selection_screen.dart';

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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const FunctionSelectionScreen(); // send_money_screen 페이지로 이동
                    }),
                  (route) => false,
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
