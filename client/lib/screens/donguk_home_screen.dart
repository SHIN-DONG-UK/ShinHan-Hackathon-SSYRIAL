import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';

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
                  child: Center(child: Text(
                    '1,520,120 원',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),)
              ),
              SizedBox(height: 20),
              _buildTransfer('돈 보내기'),
              SizedBox(height: 10),
              _buildButton('통장 생성'),
              SizedBox(height: 10),
              _buildButton('통장 조회'),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.mic, size: 40),),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransfer(String text) {
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
        onPressed: ()=>AccountInfoInputScreen(),
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