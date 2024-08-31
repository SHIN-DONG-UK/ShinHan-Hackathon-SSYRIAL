import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_keypad_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_check_dialog.dart';

class MoneyTransferScreen extends StatefulWidget {
  @override
  _MoneyTransferScreenState createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  String _balance = ''; // 잔고(숫자) API에서 가져온 값을 저장
  String _enteredMoney = ''; // 보낼 돈을 저장해놓는 변수

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _enteredMoney = _controller.text; // Update _enteredMoney as text changes
      });
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(),
              SizedBox(height: 20),
              Text(
                '얼마를 보낼까요?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildInfoBox(
                '남은 돈',
                Text(
                  '1,500,000 원',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              _buildInfoBox(
                '보낼 돈',
                _buildAmountInputField(),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: _enteredMoney.isNotEmpty,
                child: _buildButton(context, '보내기', _showConfirmationDialog)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // 이전 화면으로 이동
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '돌아가기',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,  // Use the passed in onPressed parameter here
      ),
    );
  }
  Widget _buildInfoBox(String title, Widget content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          content, // Display the content (now supports both String and Widget)
        ],
      ),
    );
  }

  // Method to build the TextField for amount input
  Widget _buildAmountInputField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '입력해 주세요.',
        border: OutlineInputBorder(),
      ),
      onChanged: (text) {
        setState(() {
          _enteredMoney = text;
        });
      },
    );
  }
}