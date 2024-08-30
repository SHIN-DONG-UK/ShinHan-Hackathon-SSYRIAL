import 'package:flutter/material.dart';
import 'package:ssyrial/screens/guide/function_selection_screen.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_memo_dialog.dart';
import 'package:ssyrial/screens/donguk_home_screen.dart';

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
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                          return WhatToWritePopup();
                  });
                },
                child: Text(
                  '네',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context){
                      return DongukHomeScreen();
                    }),
                    (route) => false,
                  ); // 현재 팝업 닫기

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
}