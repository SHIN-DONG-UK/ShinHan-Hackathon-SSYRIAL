import 'package:flutter/material.dart';

class PasswordPopup extends StatefulWidget {
  final VoidCallback onPasswordSet; // 비밀번호 설정 성공 시 호출되는 콜백

  PasswordPopup({required this.onPasswordSet});

  @override
  _PasswordPopupState createState() => _PasswordPopupState();
}

class _PasswordPopupState extends State<PasswordPopup> {
  String _password = ''; // 첫 번째 입력된 비밀번호
  String _confirmPassword = ''; // 비밀번호 확인용
  bool _isConfirming = false; // 비밀번호 확인 단계인지 여부

  void _addDigit(String digit) {
    setState(() {
      if (!_isConfirming) {
        if (_password.length < 6) _password += digit;
      } else {
        if (_confirmPassword.length < 6) _confirmPassword += digit;
      }
    });
  }

  void _removeDigit() {
    setState(() {
      if (!_isConfirming && _password.isNotEmpty) {
        _password = _password.substring(0, _password.length - 1);
      } else if (_isConfirming && _confirmPassword.isNotEmpty) {
        _confirmPassword = _confirmPassword.substring(0, _confirmPassword.length - 1);
      }
    });
  }

  void _confirmPasswordEntry() {
    if (_password.length == 6 && _confirmPassword.length == 6) {
      if (_password == _confirmPassword) {
        widget.onPasswordSet(); // 비밀번호 설정 성공 콜백 호출
        Navigator.of(context).pop(); // 팝업 닫기
      } else {
        _showPasswordFailPopup();
      }
    }
  }

  void _showPasswordFailPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('비밀번호 불일치'),
          content: Text('비밀번호가 일치하지 않습니다. 다시 시도해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _confirmPassword = ''; // 확인 비밀번호 초기화
                  _isConfirming = false; // 다시 비밀번호 입력 단계로 전환
                });
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isConfirming ? '비밀번호를 다시 입력해주세요.' : '6자리 비밀번호를 입력해주세요.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildPasswordDisplay(),
            SizedBox(height: 20),
            _buildNumberPad(),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordDisplay() {
    String displayText = !_isConfirming
        ? '* ' * _password.length + '  ' * (6 - _password.length)
        : '* ' * _confirmPassword.length + '  ' * (6 - _confirmPassword.length);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        displayText,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildNumberPad() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        for (var i = 1; i <= 9; i++) _buildNumberButton(i.toString()),
        _buildActionButton('모두지우기', Colors.grey, () {
          setState(() {
            if (!_isConfirming) {
              _password = '';
            } else {
              _confirmPassword = '';
            }
          });
        }),
        _buildNumberButton('0'),
        _buildActionButton('하나지우기', Colors.grey, _removeDigit),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      child: Text(number, style: TextStyle(fontSize: 24)),
      onPressed: () => _addDigit(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(text, style: TextStyle(fontSize: 14)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildActionButtons() {
    return ElevatedButton(
      child: Text(_isConfirming ? '확인' : '다음', style: TextStyle(fontSize: 18)),
      onPressed: _isConfirming
          ? (_confirmPassword.length == 6 ? _confirmPasswordEntry : null)
          : (_password.length == 6
          ? () {
        setState(() {
          _isConfirming = true; // 비밀번호 확인 단계로 전환
        });
      }
          : null),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    );
  }
}

// 비밀번호 설정 팝업을 표시하는 함수
void showPasswordPopup(BuildContext context, VoidCallback onPasswordSet) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PasswordPopup(onPasswordSet: onPasswordSet);
    },
  );
}
