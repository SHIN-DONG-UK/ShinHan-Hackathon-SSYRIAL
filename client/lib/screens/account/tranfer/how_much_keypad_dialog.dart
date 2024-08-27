import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showKeypadDialog(context);
          },
          child: Text('Show Keypad Dialog'),
        ),
      ),
    );
  }

  void _showKeypadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HowMuchKeypadDialog();
      },
    );
  }
}

class HowMuchKeypadDialog extends StatefulWidget {
  @override
  _HowMuchKeypadDialogState createState() => _HowMuchKeypadDialogState();
}

class _HowMuchKeypadDialogState extends State<HowMuchKeypadDialog> {
  // Controller for the amount input
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('금액을 입력하세요'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 2. Container1(회색) - 현재 입력된 금액
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16.0),
            child: Text(
              _amountController.text.isEmpty ? '0' : _amountController.text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),

          // 3. Container2 - 숫자 키패드
          Container(
            child: Column(
              children: [
                _buildKeypadRow(['1', '2', '3']),
                _buildKeypadRow(['4', '5', '6']),
                _buildKeypadRow(['7', '8', '9']),
                _buildKeypadRow(['모두 지우기', '0', '하나 지우기']),
              ],
            ),
          ),
          SizedBox(height: 20),

          // 4. Container3 - 취소 및 완료 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  _handleCompletion(context);
                },
                child: Text('완료'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build a row for the keypad
  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return TextButton(
          onPressed: () {
            _handleKeypadInput(key);
          },
          child: Text(
            key,
            style: TextStyle(fontSize: 24),
          ),
        );
      }).toList(),
    );
  }

  // Handle keypad input
  void _handleKeypadInput(String key) {
    setState(() {
      if (key == '모두 지우기') {
        _amountController.clear();
      } else if (key == '하나 지우기') {
        final currentText = _amountController.text;
        if (currentText.isNotEmpty) {
          _amountController.text = currentText.substring(0, currentText.length - 1);
        }
      } else {
        _amountController.text += key;
      }
    });
  }

  // Handle the completion of input
  void _handleCompletion(BuildContext context) {
    final enteredAmount = _amountController.text;

    // Here you might want to pass this amount to the main screen or other parts of your app
    // For now, we'll just close the dialog
    Navigator.of(context).pop(); // Close the dialog
    Navigator.of(context).pop(); // Optionally close the previous screen or do other actions
    // TODO: Pass enteredAmount to `send_money_screen.dart`'s mini box2 Text Widget
  }
}
