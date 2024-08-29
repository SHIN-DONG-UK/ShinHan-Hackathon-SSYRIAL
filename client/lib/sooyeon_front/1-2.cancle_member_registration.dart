import 'package:flutter/material.dart';
import '1.home_screen.dart';  // HomeScreen을 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Cancel Dialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),  // 기본 홈 화면을 HomeScreen으로 설정
    );
  }
}

class CancelMemberRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 등록 취소'),
      ),
      body: Center(
        child: SignUpCancelDialog(), // 취소 다이얼로그를 화면에 바로 표시
      ),
    );
  }
}

class SignUpCancelDialog extends StatelessWidget {
  const SignUpCancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 네 버튼 클릭 시 home_screen으로 이동
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(100, 40),
              ),
              onPressed: () {
                // 네 버튼을 누르면 HomeScreen으로 이동
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,  // 이전 화면을 모두 제거
                );
              },
              child: const Text(
                '네',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '회원 등록을 취소할까요?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // 아니오 버튼 클릭 시 다이얼로그 닫기
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(100, 40),
              ),
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: const Text(
                '아니오',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 다이얼로그를 표시하는 함수
void showSignUpCancelDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SignUpCancelDialog();
    },
  );
}
