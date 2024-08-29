// personal_information_choose_gender.dart

import 'package:flutter/material.dart';
import '1-2.cancle_member_registration.dart';
import '8.authentication_start.dart'; // 인증 시작 화면을 임포트

class PersonalInformationChooseGender extends StatefulWidget {
  final String birthday;
  final String initialName;

  PersonalInformationChooseGender({required this.birthday, required this.initialName});

  @override
  _PersonalInformationChooseGenderState createState() => _PersonalInformationChooseGenderState();
}

class _PersonalInformationChooseGenderState extends State<PersonalInformationChooseGender> {
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
                '성별이 무엇입니까?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // 성별 선택 컨테이너
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('성별'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text('남자'),
                            onPressed: () => setGender('남자'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedGender == '남자' ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('여자'),
                            onPressed: () => setGender('여자'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedGender == '여자' ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('다음'),
                  onPressed: selectedGender != null
                      ? () {
                    print('선택된 성별: $selectedGender');
                    print('생년월일: ${widget.birthday}');
                    print('이름: ${widget.initialName}');
                    // 다음 화면으로 이동 로직 (AuthenticationStart 화면으로)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthenticationStart(),
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

  void setGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }
}
