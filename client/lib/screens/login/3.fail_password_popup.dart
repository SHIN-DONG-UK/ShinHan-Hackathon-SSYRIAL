import 'package:flutter/material.dart';
import 'dart:async'; // Timer를 사용하기 위해 추가

// 상수 정의
const double kDialogWidth = 300;
const double kDialogHeight = 200;
const double kIconSize = 80;
const double kIconFontSize = 40;
const double kHeaderFontSize = 18;
const double kMessageFontSize = 16;
const double kButtonPaddingVertical = 15;

const Color kDialogBackgroundColor = Colors.white;
const Color kIconBackgroundColor = Colors.red;
const Color kIconTextColor = Colors.white;
const Color kHeaderBackgroundColor = Color(0xFFFFF0F5); // Colors.pink[50]과 동일
const Color kHeaderTextColor = Colors.black;
const Color kButtonBackgroundColor = Colors.blue;
const Color kButtonTextColor = Colors.white;
const Color kMessageTextColor = Colors.black;

const BorderRadius kDialogBorderRadius = BorderRadius.all(Radius.circular(20));
const BorderRadius kHeaderBorderRadius = BorderRadius.vertical(top: Radius.circular(20));
const BorderRadius kButtonBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);

class FailPasswordPopup extends StatefulWidget {
  const FailPasswordPopup({Key? key}) : super(key: key);

  // 팝업을 표시하는 정적 메서드
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const FailPasswordPopup();
      },
    );
  }

  @override
  _FailPasswordPopupState createState() => _FailPasswordPopupState();
}

class _FailPasswordPopupState extends State<FailPasswordPopup> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머가 실행 중이면 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: buildDialogShape(), // Dialog의 모양 설정
      child: Container(
        width: kDialogWidth,
        height: kDialogHeight,
        decoration: buildContainerDecoration(), // 컨테이너의 데코레이션 설정
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildHeader(), // 헤더 빌드
            buildIcon(), // 아이콘 빌드
            buildMessage(), // 메시지 빌드
            buildActionButtons(context), // 액션 버튼 빌드
          ],
        ),
      ),
    );
  }

  // FailPasswordPopup 위젯들을 관리하는 extension
  RoundedRectangleBorder buildDialogShape() {
    return RoundedRectangleBorder(
      borderRadius: kDialogBorderRadius,
    );
  }

  // 컨테이너 데코레이션 설정
  BoxDecoration buildContainerDecoration() {
    return BoxDecoration(
      color: kDialogBackgroundColor,
      borderRadius: kDialogBorderRadius,
    );
  }

  // 헤더 빌드
  Widget buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: kHeaderBackgroundColor,
        borderRadius: kHeaderBorderRadius,
      ),
      child: const Text(
        'FAIL_POPUP',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: kHeaderFontSize,
          color: kHeaderTextColor,
        ),
      ),
    );
  }

  // 아이콘 빌드
  Widget buildIcon() {
    return Container(
      width: kIconSize,
      height: kIconSize,
      decoration: const BoxDecoration(
        color: kIconBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'X',
          style: TextStyle(
            color: kIconTextColor,
            fontSize: kIconFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 메시지 빌드
  Widget buildMessage() {
    return const Text(
      '비밀번호가 틀렸어요.',
      style: TextStyle(
        fontSize: kMessageFontSize,
        color: kMessageTextColor,
      ),
    );
  }

  // 액션 버튼 빌드
  Widget buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(), // 확인 버튼 눌렀을 때의 동작
            child: Container(
              decoration: BoxDecoration(
                color: kButtonBackgroundColor,
                borderRadius: kButtonBorderRadius,
              ),
              padding: const EdgeInsets.symmetric(vertical: kButtonPaddingVertical),
              child: const Text(
                '확인',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kButtonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
