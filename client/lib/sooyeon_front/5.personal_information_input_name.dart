import 'package:flutter/material.dart';
import '1-2.cancle_member_registration.dart';  // 회원 등록 취소 화면 임포트
import '6.personal_information_input_birtyday.dart'; // 생년월일 입력 화면 임포트

// PersonalInformationInputName 클래스 정의
class PersonalInformationInputName extends StatefulWidget {
  @override
  _PersonalInformationInputNameState createState() =>
      _PersonalInformationInputNameState();
}

class _PersonalInformationInputNameState
    extends State<PersonalInformationInputName> {
  TextEditingController _nameController = TextEditingController();

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
                '이름을 입력해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이름'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: '입력해 주세요.',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        // 입력값이 변경될 때마다 상태 업데이트
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('다음'),
                  onPressed: _nameController.text.isNotEmpty
                      ? () {
                    // 이름 입력 후 다음 화면으로 이동
                    print('이름: ${_nameController.text}');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationInputBirthday(
                          initialName: _nameController.text,
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// main 함수
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Information Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonalInformationInputName(),
    );
  }
}
