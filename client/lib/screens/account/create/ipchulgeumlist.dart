import 'package:flutter/material.dart';

class Ipchulgeumlist extends StatelessWidget {
  const Ipchulgeumlist({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 이전 화면으로 돌아가기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // 버튼 배경색
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                  ),
                ),
                child: const Text(
                  '돌아가기',
                  style: TextStyle(
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 두께
                    color: Colors.white, // 글자 색상
                    letterSpacing: 1.5, // 글자 간격
                  ),
                ),
              ),
              const Text(
                "생성을 원하는\n입출금 상품을\n선택하세요.",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: ListView(
                  children: [
                    ElevatedButton(
                      onPressed: (){print("hello");},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 버튼 배경색
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                        ),
                      ),
                      child: const Text(
                        "test 1 입출금 통장\n 연 0.1% ~ 2.0%",
                        style: TextStyle(
                          fontSize: 18, // 글자 크기
                          fontWeight: FontWeight.bold, // 글자 두께
                          color: Colors.white, // 글자 색상
                          letterSpacing: 1.5, // 글자 간격
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),

                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 버튼 배경색
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                        ),
                      ),
                      child: const Text(
                        "test 1 입출금 통장\n 연 0.2% ~ 1.1%",
                        style: TextStyle(
                          fontSize: 18, // 글자 크기
                          fontWeight: FontWeight.bold, // 글자 두께
                          color: Colors.white, // 글자 색상
                          letterSpacing: 1.5, // 글자 간격
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),

                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 버튼 배경색
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                        ),
                      ),
                      child: const Text(
                        "test 1 입출금 통장\n 연 1.1% ~ 2.8%",
                        style: TextStyle(
                          fontSize: 18, // 글자 크기
                          fontWeight: FontWeight.bold, // 글자 두께
                          color: Colors.white, // 글자 색상
                          letterSpacing: 1.5, // 글자 간격
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
