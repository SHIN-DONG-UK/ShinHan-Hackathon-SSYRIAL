import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  final VoidCallback onAuthenticationComplete;

  const AuthenticationScreen({required this.onAuthenticationComplete});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isAuthenticated = false;

  void _startAuthentication() {
    setState(() {
      _isAuthenticated = true;
    });

    widget.onAuthenticationComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_isAuthenticated)
            Text(
              '초록색을\n눌러주세요.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          if (_isAuthenticated)
            Text(
              '인증이 완료되었습니다!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          SizedBox(height: 20),
          if (!_isAuthenticated)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('전화 번호 인증 시작', style: TextStyle(fontSize: 18)),
                onPressed: _startAuthentication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
