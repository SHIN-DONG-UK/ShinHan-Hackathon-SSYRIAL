import 'package:flutter/material.dart';

// CustomDialog 클래스를 정의합니다.
class CustomDialog2 extends StatelessWidget {
  final String title;
  final String name;
  final String bank;
  final String account;
  final VoidCallback onConfirm;

  CustomDialog2({
    required this.title,
    required this.name,
    required this.bank,
    required this.account,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 모서리 둥글기 설정
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0, // 글꼴 크기
          fontWeight: FontWeight.bold, // 글꼴 굵기
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0), // 내용 패딩 조절
      content: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 30), // 위젯 사이에 16픽셀 높이의 공백 추가
              Padding(padding: EdgeInsets.all(3), child: Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
              Padding(padding: EdgeInsets.all(3), child: Text(bank, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),),
              Padding(padding: EdgeInsets.all(3), child: Text(account, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),),
              SizedBox(height: 30,),
              TextButton(onPressed: (){}, child: Text('네, 다음으로 넘어가요'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 23.0), // 내부 패딩 설정
                  backgroundColor: Colors.green, // 배경색 설정
                  foregroundColor: Colors.white, // 텍스트 색상 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // 모서리 둥글기 설정
                  ),
                ),),
              SizedBox(height: 5,),
              TextButton(onPressed: (){}, child: Text('아니오'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 23.0), // 내부 패딩 설정
                  backgroundColor: Colors.grey, // 배경색 설정
                  foregroundColor: Colors.white, // 텍스트 색상 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // 모서리 둥글기 설정
                  ),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
