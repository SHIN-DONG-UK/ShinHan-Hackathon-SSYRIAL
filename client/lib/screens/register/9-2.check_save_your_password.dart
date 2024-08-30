import 'package:flutter/material.dart';
import '9-3.password_fail_popup.dart'; // password_fail_popup.dart를 임포트
import '10.finish_member_registration.dart'; // finish_member_registration.dart 파일 임포트

class CheckSaveYourPassword extends StatefulWidget {
  final String enteredPassword;

  CheckSaveYourPassword({required this.enteredPassword});

  @override
  _CheckSaveYourPasswordState createState() => _CheckSaveYourPasswordState();
}

class _CheckSaveYourPasswordState extends State<CheckSaveYourPassword> {
  String password = '';

  void addDigit(String digit) {
    if (password.length < 6) {
      setState(() {
        password += digit;
      });
    }
  }

  void removeDigit() {
    if (password.isNotEmpty) {
      setState(() {
        password = password.substring(0, password.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '입력한 비밀번호를 다시 입력해주세요.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '* ' * password.length + '  ' * (6 - password.length),
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  for (var i = 1; i <= 9; i++) buildNumberButton(i.toString()),
                  buildActionButton('재배열', Colors.grey),
                  buildNumberButton('0'),
                  buildActionButton('하나지우기', Colors.grey),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('확인', style: TextStyle(fontSize: 18)),
                onPressed: password.length == 6 ? () {
                  if (password == widget.enteredPassword) {
                    // 비밀번호가 일치하면 finish_member_registration.dart 화면으로 이동
                    // [DB] 완료 버튼 클릭 시 DB에 사용자 비밀번호 저장하기
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinishMemberRegistrationScreen(),
                      ),
                    );
                  } else {
                    // 비밀번호가 틀리면 팝업을 표시
                    showPasswordFailPopup(context);
                  }
                } : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberButton(String number) {
    return ElevatedButton(
      child: Text(number, style: TextStyle(fontSize: 24)),
      onPressed: () => addDigit(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget buildActionButton(String text, Color color) {
    return ElevatedButton(
      child: Text(text, style: TextStyle(fontSize: 14)),
      onPressed: text == '하나지우기' ? removeDigit : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
