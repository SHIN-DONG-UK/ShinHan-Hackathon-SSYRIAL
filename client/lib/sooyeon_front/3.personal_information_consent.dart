import 'package:flutter/material.dart';
import '4.personal_information_all_consent.dart';
import '1-2.cancle_member_registration.dart';

class PersonalInformationConsent extends StatefulWidget {
  @override
  _PersonalInformationConsentState createState() => _PersonalInformationConsentState();
}

class _PersonalInformationConsentState extends State<PersonalInformationConsent> {
  List<bool> _isChecked = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: Text('취소하기', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CancelMemberRegistrationScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                '회원 등록을 위해\n항목에 동의해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildConsentItem('필수 항목 전체 동의', 0),
              _buildConsentItem('[필수] 개인정보 수집이용', 1),
              _buildConsentItem('[필수] 고유식별정보처리 동의', 2),
              _buildConsentItem('[필수] 통신사 이용약관', 3),
              _buildConsentItem('[필수] 서비스 이용 동의', 4),
              Spacer(),
              Text('시작하기 위해 회원 등록을 진행할까요?', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('다음'),
                  onPressed: _isChecked[0] ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationAllConsent(isAllConsented: true),
                      ),
                    );
                  } : null,
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

  Widget _buildConsentItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[index],
            onChanged: (bool? value) {
              setState(() {
                _isChecked[index] = value!;
                if (index == 0) {
                  for (int i = 1; i < _isChecked.length; i++) {
                    _isChecked[i] = value;
                  }
                } else {
                  _isChecked[0] = _isChecked.sublist(1).every((element) => element);
                }
              });
            },
          ),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}