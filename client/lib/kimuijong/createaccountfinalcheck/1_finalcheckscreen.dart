import 'package:flutter/material.dart';
import '2_createfinished.dart';

class Finalcheckscreen extends StatelessWidget {
  const Finalcheckscreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 이전 화면으로 돌아가기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // 버튼 배경색
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                  ),
                ),
                child: const Text(
                  '아니오',
                  style: TextStyle(
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 두께
                    color: Colors.white, // 글자 색상
                    letterSpacing: 1.5, // 글자 간격
                  ),
                ),
              ),
              Text(
                "이 계좌를\n만들까요?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: ()=>{Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateFinishedScreen()),
                )},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "네",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
