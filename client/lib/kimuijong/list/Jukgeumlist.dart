import 'package:flutter/material.dart';

class Jukgeumlist extends StatelessWidget {
  const Jukgeumlist({super.key});



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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 패딩
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 버튼 모서리 둥글게
                  ),
                ),
                child: Text(
                  '돌아가기',
                  style: TextStyle(
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 두께
                    color: Colors.white, // 글자 색상
                    letterSpacing: 1.5, // 글자 간격
                  ),
                ),
              ),
              Text(
                "생성을 원하는\n적금 상품을\n선택하세요.",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildAccountOption("test 1 적금 통장", "연 2.8% ~ 5.6%"),
                    SizedBox(height: 16.0),
                    _buildAccountOption("test 2 적금 통장", "연 5.6% ~ 11.2%"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountOption(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
