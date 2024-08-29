import 'package:flutter/material.dart';
import '2.phonenum_authentication_start.dart'; // phonenum_authentication_start.dart 파일을 임포트
import '1-2.cancle_member_registration.dart'; // cancle_member_registration.dart 파일을 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member Registration Start',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: MemberRegistrationStartScreen(),
    );
  }
}

class MemberRegistrationStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  // 취소하기 버튼을 누르면 cancle_member_registration.dart 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelMemberRegistrationScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    '취소하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '시작하기 위해\n회원 등록을\n진행할게요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // phonenum_authentication_start.dart로 화면 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PhoneNumAuthenticationStart(), // 전화번호 인증 화면으로 이동
                            ),
                          );
                        },
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
