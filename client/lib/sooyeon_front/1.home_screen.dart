import 'package:flutter/material.dart';
import '2.sign_in_password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOL Bank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Text(
            '홈',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(icon: Icon(Icons.message, color: Colors.black), onPressed: () {}),
          IconButton(icon: Icon(Icons.mic, color: Colors.black), onPressed: () {}),
          IconButton(icon: Icon(Icons.person, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Image.asset('assets/sol_bank_logo.png', height: 90),
                  ElevatedButton(
                    child: Text('로그인'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Super SOL', style: TextStyle(color: Colors.blue)),
                      Text('카드', style: TextStyle(color: Colors.grey)),
                      Text('은행', style: TextStyle(color: Colors.grey)),
                      Text('보험', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 100,
                          color: Colors.orange,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('계좌 생성하기', style: TextStyle(color: Colors.white)),
                              Icon(Icons.star, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            // 버튼 클릭 시 SignInScreen 화면으로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                            );
                          },
                          child: Container(
                            height: 100,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                '쉬운 화면\n실행하기',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [Icon(Icons.home), Text('홈')]),
                Column(children: [Icon(Icons.search), Text('자산관리')]),
                Column(children: [Icon(Icons.send), Text('상품')]),
                Column(children: [Icon(Icons.account_balance), Text('헤택')]),
                Column(children: [Icon(Icons.menu), Text('전체메뉴')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}