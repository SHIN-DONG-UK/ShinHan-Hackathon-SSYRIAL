import 'package:flutter/material.dart';
import '1-2.cancle_member_registration.dart';  // 회원 등록 취소 화면 임포트
import '7.personal_information_choose_gender.dart'; // 성별 선택 화면 임포트
import 'package:flutter/services.dart';

// PersonalInformationInputBirthday 클래스 정의
class PersonalInformationInputBirthday extends StatefulWidget {
  final String initialName;

  PersonalInformationInputBirthday({required this.initialName});

  @override
  _PersonalInformationInputBirthdayState createState() =>
      _PersonalInformationInputBirthdayState();
}

class _PersonalInformationInputBirthdayState
    extends State<PersonalInformationInputBirthday> {
  TextEditingController _birthdayController = TextEditingController();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // 초기 이름 설정
    _nameController = TextEditingController(text: widget.initialName);
  }

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
                '6자리 생년월일을 입력해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // 생년월일 입력 컨테이너
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('생년월일'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        hintText: 'oooooo',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (value) {
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
                  onPressed: (_birthdayController.text.length == 6 &&
                      _nameController.text.isNotEmpty)
                      ? () {
                    print('생년월일: ${_birthdayController.text}');
                    // 다음 화면으로 이동 로직
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationChooseGender(
                          birthday: _birthdayController.text,
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
    _birthdayController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}