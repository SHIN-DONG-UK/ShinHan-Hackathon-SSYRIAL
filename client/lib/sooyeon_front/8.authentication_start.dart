import 'package:flutter/material.dart';
import '1-2.cancle_member_registration.dart';
import '9.save_your_password.dart'; // save_your_password.dart를 임포트

class AuthenticationStart extends StatefulWidget {
  @override
  _AuthenticationStartState createState() => _AuthenticationStartState();
}

class _AuthenticationStartState extends State<AuthenticationStart> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 취소하기 버튼
              TextButton(
                child: Text(
                  '취소하기',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelMemberRegistrationScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                '초록색을\n눌러주세요.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // 인증 시작 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('전화 번호 인증 시작', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    // 다음 화면으로 이동 로직
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaveYourPassword(), // SaveYourPassword 화면으로 이동
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Screen')),
      body: Center(child: Text('This is the next screen!')),
    );
  }
}
