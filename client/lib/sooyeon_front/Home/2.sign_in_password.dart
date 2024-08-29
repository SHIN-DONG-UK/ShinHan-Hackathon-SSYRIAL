import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 서버 연결 시 사용하는 패키지 추가
import 'dart:async'; // 타이머 기능 추가
import '3.fail_password_popup.dart'; // Fail Password Popup 연결

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String password = '';
  String correctPassword = '123456'; // 서버에서 가져온 비밀번호로 대체 가능

  // 숫자를 추가하는 함수
  void addNumber(String number) {
    if (password.length < 6) {
      setState(() {
        password += number;
      });
    }
  }

  // 숫자를 지우는 함수
  void removeNumber() {
    if (password.isNotEmpty) {
      setState(() {
        password = password.substring(0, password.length - 1);
      });
    }
  }

  // 비밀번호를 초기화하는 함수
  void clearPassword() {
    setState(() {
      password = '';
    });
  }

  // 비밀번호 확인 함수
  void verifyPassword() {
    if (password == correctPassword) {
      print('비밀번호 일치');
      // 비밀번호 일치 시의 로직 추가
    } else {
      print('비밀번호 불일치');
      showFailPopup(); // 비밀번호 불일치 시 팝업 호출
    }
  }

  // 비밀번호 불일치 시 Fail Popup을 3초간 보여줌
  void showFailPopup() {
    showFailPasswordPopup(context); // 팝업 표시
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pop(); // 3초 후 팝업 닫기
      clearPassword(); // 비밀번호 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.pink[50],
                child: Column(
                  children: [
                    Text(
                      '6자리 비밀번호를 \n 입력해 주세요.',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                            (index) => Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            index < password.length ? '*' : '',
                            style: TextStyle(
                              fontSize: 24,
                              color: index < password.length ? Colors.black : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.pink[50],
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    padding: EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      ...List.generate(
                        9,
                            (index) => ElevatedButton(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => addNumber('${index + 1}'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          '재배열',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        onPressed: clearPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: Size(double.infinity, 60),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('0'),
                        onPressed: () => addNumber('0'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      ),
                      ElevatedButton(
                        child: Text(
                          '하나\n지우기',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        onPressed: removeNumber,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: Size(double.infinity, 60),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.pop(context);
                        print('취소 버튼 클릭됨');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(double.infinity, 60),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('완료'),
                      onPressed: verifyPassword, // 비밀번호 확인 호출
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 60),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
