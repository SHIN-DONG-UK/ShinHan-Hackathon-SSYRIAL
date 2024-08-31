import 'package:flutter/material.dart';
import 'package:ssyrial/screens/donguk_home_screen.dart';
import 'package:ssyrial/config/hive_config.dart';
import 'package:ssyrial/screens/login/2.sign_in_password.dart';
import 'package:ssyrial/screens/register/member_registration_screen.dart';

// 상수 정의
const Color kEasyScreenColor = Colors.green;

const TextStyle kButtonTextStyle = TextStyle(color: Colors.white, fontSize: 18);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //화면 크기 변환 변수
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/shinhan_home_screen.png', // 여기에 이미지 경로를 맞춰주세요
              fit: BoxFit.fitHeight, // 이미지를 화면에 꽉 차게 설정
            ),
          ),
          Positioned(
            top: screenwidth,
            child: SizedBox(
              width: screenwidth,
              height: screenheight,
              child: TextButton(
                onPressed: () {_handleEasyScreenButtonPress(context);
                },
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                ),
                child: Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 쉬운 화면 버튼 클릭 처리
  Future<void> _handleEasyScreenButtonPress(BuildContext context) async {
    try {
      /*
      // Hive Box 열기
      var box = await HiveConfig.openBox('registrationBox');

      final isRegistered = box.get('isRegistrationComplete', defaultValue: false);

      // 등록 상태에 따른 페이지 이동
      if (isRegistered) {
        onLoginButtonPressed(context);
      } else {
        onEasyScreenButtonPressed(context);
      }
      // Box 닫기
      await HiveConfig.closeBox('registrationBox');
       */
      onEasyScreenButtonPressed(context);
    } catch (e) {
      // 예외 처리 - 오류 발생 시 로그 출력
      print('Hive 저장 중 오류 발생: $e');
    }
  }

  // 로그인 버튼을 눌렀을 때의 동작
  void onLoginButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()), // SignInScreen 화면으로 이동
    );
  }

  // 쉬운 화면 버튼을 눌렀을 때의 동작
  void onEasyScreenButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemberRegistrationStartScreen()), // MemberRegistrationStartScreen 화면으로 이동
    );
  }
}
