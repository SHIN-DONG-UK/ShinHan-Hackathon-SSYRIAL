import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/create/create_account_select_category.dart';
import 'package:ssyrial/screens/auth/help_screen.dart';
import 'package:ssyrial/widgets/custom_dialog.dart';
import 'package:ssyrial/sooyeon_front/Home/1.home_screen.dart' as sooyeon;

class HomeScreen extends StatelessWidget {
  final String title; // 화면의 제목
  final String buttonText; // 버튼에 표시할 텍스트
  final TextStyle? titleTextStyle; // 제목 텍스트 스타일
  final TextStyle? buttonTextStyle; // 버튼 텍스트 스타일
  final Color buttonColor; // 버튼 배경색
  final double buttonPadding; // 버튼의 패딩

  const HomeScreen({
    super.key,
    this.title = 'SOL Bank',
    this.buttonText = '도움말 모드',
    this.titleTextStyle,
    this.buttonTextStyle,
    this.buttonColor = Colors.blue, // 기본 버튼 색상
    this.buttonPadding = 16.0, // 기본 버튼 패딩
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: titleTextStyle), // 제목과 스타일 설정
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(buttonPadding), // 버튼 주위의 패딩 설정
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // 도움말 다이얼로그 표시
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(child: HelpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // 버튼 배경색 설정
                ),
                child: Text(buttonText, style: buttonTextStyle), // 버튼 텍스트 및 스타일 설정
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccoutSelectCategory()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // 버튼 배경색 설정
                ),
                child: Text("계좌 생성하기", style: buttonTextStyle), // 버튼 텍스트 및 스타일 설정
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => sooyeon.HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // 버튼 배경색 설정
                ),
                child: Text("수연홈스크린", style: buttonTextStyle), // 버튼 텍스트 및 스타일 설정
              ),
            ],
          ),
        ),
      ),
    );
  }
}
