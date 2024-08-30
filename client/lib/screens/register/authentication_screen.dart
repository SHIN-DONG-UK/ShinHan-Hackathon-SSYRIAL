import 'package:flutter/material.dart';
import 'package:ssyrial/config/tts_config.dart';

class AuthenticationScreen extends StatefulWidget {
  final VoidCallback onAuthenticationComplete;

  const AuthenticationScreen({Key? key, required this.onAuthenticationComplete}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isAuthenticated = false;
  final TTSConfig _ttsConfig = TTSConfig();

  @override
  void initState() {
    super.initState();
    _speakAuthenticationInstructions();
  }

  Future<void> _speakAuthenticationInstructions() async {
    await _ttsConfig.initTTS();
    await _ttsConfig.speak("인증 버튼을 눌러주세요.");
  }

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
          _buildAuthenticationText(),
          const SizedBox(height: 20),
          if (!_isAuthenticated) _buildAuthenticationButton(),
        ],
      ),
    );
  }

  Widget _buildAuthenticationText() {
    return Text(
      _isAuthenticated ? '인증이 완료되었습니다!' : '인증 버튼을\n눌러주세요.',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _isAuthenticated ? Colors.green : Colors.black,
      ),
    );
  }

  Widget _buildAuthenticationButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('인증 시작', style: TextStyle(fontSize: 18)),
        onPressed: _startAuthentication,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}