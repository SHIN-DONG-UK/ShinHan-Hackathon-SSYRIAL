import 'package:flutter/material.dart';
import '../createaccountfinalcheck/1_finalcheckscreen.dart';
import 'dart:async';

class Ipchulgeumabiliablecheck extends StatefulWidget {
  const Ipchulgeumabiliablecheck({super.key});

  @override
  _IpchulgeumabiliablecheckState createState() => _IpchulgeumabiliablecheckState();
}

class _IpchulgeumabiliablecheckState extends State<Ipchulgeumabiliablecheck> {
  final StreamController<String> _streamController = StreamController<String>();

  @override
  void dispose() {
    _streamController.close(); // Close the stream when the widget is disposed
    super.dispose();
  }

  void _showStreamAlertDialog(BuildContext context) {
    // Function to send updated messages to the stream
    void updateMessage() {
      // Add initial message
      _streamController.add('한 달 이내에\n입출금 통장이\n개설되었는지\n확인하고 있어요.\n(1/2)');

      // Simulate message update after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        if (Navigator.canPop(context)) {
          _streamController.add('기존에 소유한\n한도 제한 계좌가\n있는지\n확인하고 있어요.\n(2/2)');
        }
      });
      Future.delayed(Duration(seconds: 6), () {
        if (Navigator.canPop(context)) {
          _streamController.add('이 계좌를\n생성할 수 있어요.');
        }
      });
      Future.delayed(Duration(seconds: 10), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Finalcheckscreen()),
        );
      });
    }

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Start updating the message
        updateMessage();

        return StreamBuilder<String>(
          stream: _streamController.stream,
          initialData: '초기 메시지',
          builder: (context, snapshot) {
            return AlertDialog(
              title: Text('알림'),
              content: Text(snapshot.data ?? '로딩 중...'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _streamController.close(); // Close the stream
                  },
                  child: Text('닫기'),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
              SizedBox(height: 32.0),
              _buildAccountOption("test 3 입출금 통장", "연 0.2% ~ 2.8%"),
              SizedBox(height: 32.0),
              Text(
                "이 계좌를\n만들 수 있는지\n2가지 항목을\n확인해 볼게요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _showStreamAlertDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "확인하기",
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
