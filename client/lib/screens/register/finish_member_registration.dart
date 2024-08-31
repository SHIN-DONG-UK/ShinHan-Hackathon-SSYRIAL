import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ssyrial/config/hive_config.dart';
import 'package:ssyrial/screens/donguk_home_screen.dart';
import 'package:ssyrial/screens/guide/function_selection_screen.dart';
import '../../config/constants.dart';
import 'dart:async'; // 타이머를 위해 추가

// 상수 선언
const String registrationCompleteText = '회원 등록이 완료되었어요!';
const String finishButtonText = '마치기';
const double imageWidth = 200;
const double imageHeight = 200;
const double buttonFontSize = 18;
const EdgeInsets containerPadding = EdgeInsets.all(kContainerPadding);
const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 50, vertical: 15);

class FinishMemberRegistrationScreen extends StatefulWidget {
  const FinishMemberRegistrationScreen({Key? key}) : super(key: key);

  @override
  _FinishMemberRegistrationScreenState createState() => _FinishMemberRegistrationScreenState();
}

class _FinishMemberRegistrationScreenState extends State<FinishMemberRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    // 페이지가 실행될 때 Hive에 값을 저장
    _storeRegistrationStatus();
  }

  // Hive에 회원 등록 완료 상태 저장
  Future<void> _storeRegistrationStatus() async {
    try {
      // Hive Box 열기
      var box = await HiveConfig.openBox('registrationBox');

      // 회원 등록 상태를 true로 저장
      await box.put('isRegistrationComplete', true);

      // Box 닫기
      await HiveConfig.closeBox('registrationBox');
    } catch (e) {
      // 예외 처리 - 오류 발생 시 로그 출력
      print('Hive 저장 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: containerPadding,
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //_buildRegistrationImage(), // 이미지 위젯 생성
          const SizedBox(height: 20),
          _buildCompletionText(), // 완료 메시지 텍스트 위젯 생성
          const SizedBox(height: 30),
          _buildFinishButton(context), // 완료 버튼 위젯 생성
        ],
      ),
    );
  }

  // 이미지 위젯 생성
  Widget _buildRegistrationImage() {
    return Image.asset(
      'assets/images/moli.gif', // 이미지 경로가 올바른지 확인하세요.
      width: imageWidth,
      height: imageHeight,
    );
  }

  // 완료 메시지 텍스트 위젯 생성
  Widget _buildCompletionText() {
    return Text(
      registrationCompleteText,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  // 완료 버튼 위젯 생성
  Widget _buildFinishButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _completeRegistration(context), // 등록 완료 함수 호출
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: buttonPadding,
      ),
      child: Text(
        finishButtonText,
        style: TextStyle(fontSize: buttonFontSize),
      ),
    );
  }

  // 회원 등록 완료 함수
  Future<void> _completeRegistration(BuildContext context) async {
    try {
      // FunctionSelectionScreen으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DongukHomeScreen()),
      );
    } catch (e) {
      // 예외 처리 - 오류 발생 시 사용자에게 알림
      print('등록 완료 중 오류가 발생했습니다: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('등록 중 오류가 발생했습니다. 다시 시도해주세요.')),
      );
    }
  }
}
