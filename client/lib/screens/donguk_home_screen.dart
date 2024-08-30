import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';
import 'package:ssyrial/screens/STT/stt_test.dart';

// [API] 동욱 홈 화면 진입 시 통장잔고 API 땡겨와야 함
class DongukHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.menu, size: 30),
            onPressed: (){},),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 200,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // 여기서 Text()가 아니라 통장 잔고를 API에서 땡겨와야 함
                  child: Center(child: Text(
                    '1,520,120 원',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),)
              ),
              SizedBox(height: 20),
              _buildTransfer(context, '돈 보내기'),
              SizedBox(height: 10),
              _buildButton('통장 생성'),
              SizedBox(height: 10),
              _buildButton('통장 조회'),
              Spacer(),
              _buildSTT(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSTT(BuildContext context){
    return IconButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpeechSampleApp(
            // Pass any required arguments here if needed
          ),
        ),
      );
    },
    icon: Icon(Icons.mic, size: 40),);
  }

  Widget _buildTransfer(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(text, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountInfoInputScreen(
                // Pass any required arguments here if needed
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(text, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}