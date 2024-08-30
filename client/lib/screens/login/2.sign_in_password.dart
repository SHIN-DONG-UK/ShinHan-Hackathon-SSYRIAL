import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 서버 연결 시 사용하는 패키지 추가
import 'dart:async'; // 타이머 기능 추가
import '3.fail_password_popup.dart'; // Fail Password Popup 연결
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';

// 패스워드 화면에서 사용할 상수 정의
const int kPasswordLength = 6;
const String kCorrectPassword = '123456'; // 서버에서 가져온 비밀번호로 대체 가능

const Color kPasswordBorderColor = Colors.blue;
const Color kPasswordBackgroundColor = Colors.pinkAccent;
const Color kButtonGreenColor = Colors.green;
const Color kButtonGreyColor = Colors.grey;
const Color kButtonRedColor = Colors.red;
const Color kButtonBlueColor = Colors.blue;

const TextStyle kPasswordTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
const TextStyle kPasswordIndicatorStyle = TextStyle(fontSize: 24, color: Colors.black);
const TextStyle kPasswordPlaceholderStyle = TextStyle(fontSize: 24, color: Colors.grey);

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(), // 화면의 주요 구성 요소를 빌드
    );
  }
}

// SignInScreenWidget Extension
extension SignInScreenWidget on _SignInScreenState {
  // 화면의 주요 구성 요소를 빌드하는 함수
  Widget buildBody() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPasswordBorderColor, width: 2), // 외곽선 설정
      ),
      child: SafeArea(
        child: Column(
          children: [
            buildPasswordEntrySection(), // 비밀번호 입력 섹션
            buildNumberPad(), // 숫자 패드
            buildActionButtons(), // 하단의 취소 및 완료 버튼
          ],
        ),
      ),
    );
  }

  // 비밀번호 입력 섹션 빌드
  Widget buildPasswordEntrySection() {
    return Container(
      padding: EdgeInsets.all(16),
      color: kPasswordBackgroundColor, // 배경색 설정
      child: Column(
        children: [
          Text(
            '6자리 비밀번호를 \n 입력해 주세요.',
            style: kPasswordTextStyle, // 텍스트 스타일 적용
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              kPasswordLength,
                  (index) => Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), // 외곽선 설정
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글게 설정
                ),
                alignment: Alignment.center,
                child: Text(
                  index < password.length ? '*' : '', // 비밀번호 문자 표시
                  style: index < password.length
                      ? kPasswordIndicatorStyle
                      : kPasswordPlaceholderStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 숫자 패드를 빌드하는 함수
  Widget buildNumberPad() {
    return Expanded(
      child: Container(
        color: kPasswordBackgroundColor, // 배경색 설정
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
                onPressed: () => addNumber('${index + 1}'), // 숫자 추가
                style: ElevatedButton.styleFrom(backgroundColor: kButtonGreenColor),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ), // 버튼 텍스트 스타일 설정
              ),
            ),
            ElevatedButton(
              onPressed: clearPassword, // 비밀번호 초기화
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonGreyColor, // 버튼 배경색 설정
                minimumSize: Size(double.infinity, 60),
              ),
              child: Text(
                '재배열',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => addNumber('0'), // 0 추가
              style: ElevatedButton.styleFrom(backgroundColor: kButtonGreenColor),
              child: Text('0'),
            ),
            ElevatedButton(
              onPressed: removeNumber, // 숫자 하나 지우기
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonGreyColor, // 버튼 배경색 설정
                minimumSize: Size(double.infinity, 60),
              ),
              child: Text(
                '하나\n지우기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 하단의 취소 및 완료 버튼 빌드
  Widget buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // 현재 화면 닫기
              print('취소 버튼 클릭됨');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonRedColor, // 버튼 배경색 설정
              minimumSize: Size(double.infinity, 60),
            ),
            child: Text('취소'),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          // [API] DB에 저장된 사용자 비밀번호 가져와서 사용자가 입력한 비밀번호와 일치하는지 확인하기
          child: ElevatedButton(
            onPressed: () {
              verifyPassword(context); // 비밀번호 확인 호출
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonBlueColor, // 버튼 배경색 설정
              minimumSize: Size(double.infinity, 60),
            ),
            child: Text('완료'),
          ),
        ),
      ],
    );
  }
}

// SignInScreenFunction Extension
extension SignInScreenFunction on _SignInScreenState {
  // 숫자를 추가하는 함수
  void addNumber(String number) {
    if (password.length < kPasswordLength) {
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
  void verifyPassword(BuildContext context) {
    if (password == kCorrectPassword) {
      // 비밀번호 일치 시 AccountInfoInputScreen으로 이동
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountInfoInputScreen(), // 이동할 커스텀 위젯
        ),
      );
    } else {
      print('비밀번호 불일치');
      showFailPopup(); // 비밀번호 불일치 시 팝업 호출
    }
  }

  // 비밀번호 불일치 시 Fail Popup을 3초간 보여줌
  void showFailPopup() {
    FailPasswordPopup.show(context);// 팝업 표시
  }
}
