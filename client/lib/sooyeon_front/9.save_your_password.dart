import 'package:flutter/material.dart';
import '9-2.check_save_your_password.dart'; // 실제 파일 경로를 사용하세요
import '9-3.password_fail_popup.dart'; // 실제 파일 경로를 사용하세요

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Input App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SaveYourPassword(), // 홈 화면을 SaveYourPassword로 설정
    );
  }
}

class SaveYourPassword extends StatefulWidget {
  @override
  _SaveYourPasswordState createState() => _SaveYourPasswordState();
}

class _SaveYourPasswordState extends State<SaveYourPassword> {
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
                '6자리 비밀번호를 입력해주세요.',
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('취소', style: TextStyle(fontSize: 18)),
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('완료', style: TextStyle(fontSize: 18)),
                      onPressed: password.length == 6 ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckSaveYourPassword(enteredPassword: password),
                          ),
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
                    // 비밀번호가 일치하면 현재 화면을 닫고 이전 화면으로 돌아갑니다.
                    Navigator.pop(context);
                  } else {
                    // 비밀번호가 틀리면 팝업을 표시합니다.
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

// password_fail_popup.dart의 showPasswordFailPopup 함수 정의
void showPasswordFailPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // 팝업 외부를 클릭해도 닫히지 않도록 설정
    builder: (BuildContext context) {
      return PasswordFailPopup(
        onRetry: () {
          Navigator.of(context).pop();
          // 비밀번호 재입력 로직 추가 가능
        },
        onCancel: () {
          Navigator.of(context).pop();
          // 취소 로직 추가 가능
        },
      );
    },
  );
}
