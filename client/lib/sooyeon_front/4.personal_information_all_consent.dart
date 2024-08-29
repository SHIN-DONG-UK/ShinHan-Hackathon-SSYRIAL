import 'package:flutter/material.dart';
import '5.personal_information_input_name.dart'; // input name 파일 임포트

class PersonalInformationAllConsent extends StatefulWidget {
  final bool isAllConsented;

  PersonalInformationAllConsent({required this.isAllConsented});

  @override
  _PersonalInformationAllConsentState createState() => _PersonalInformationAllConsentState();
}

class _PersonalInformationAllConsentState extends State<PersonalInformationAllConsent> {
  late bool isAllConsented;

  @override
  void initState() {
    super.initState();
    isAllConsented = widget.isAllConsented;
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
              TextButton(
                child: Text('취소하기', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
              Text(
                '회원 등록을 위해\n항목에 동의해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  child: Row(
                    children: [
                      Icon(
                        isAllConsented ? Icons.check_box : Icons.check_box_outline_blank,
                        color: isAllConsented ? Colors.blue : Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text('필수 항목 전체 동의'),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      isAllConsented = !isAllConsented;
                    });
                    _sendConsentToServer();
                  },
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('다음'),
                  onPressed: isAllConsented
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationInputName(),
                      ),
                    );
                  }
                      : null,
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

  void _sendConsentToServer() {
    print('개인정보 동의 내용 서버 전송: $isAllConsented');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Information All Consent',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PersonalInformationAllConsent(isAllConsented: false),
      routes: {
        '/next_screen': (context) => PersonalInformationInputName(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
