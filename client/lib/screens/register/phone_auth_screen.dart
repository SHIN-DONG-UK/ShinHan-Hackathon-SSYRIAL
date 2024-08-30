import 'package:flutter/material.dart';
import 'package:ssyrial/config/tts_config.dart';
import '../../config/constants.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TTSConfig ttsConfig = TTSConfig();

  @override
  void initState() {
    super.initState();
    _speakPhoneAuthMessage();
  }

  Future<void> _speakPhoneAuthMessage() async {
    await ttsConfig.initTTS(); // Initialize TTS settings
    await ttsConfig.speak("번호 인증을 위해 문자를 보내주세요."); // Speak the phone auth message
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '번호 인증을 위해\n문자를 보내주세요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          _buildPhoneAuthOption(Icons.message, '메시지'),
          SizedBox(height: 10),
          _buildPhoneAuthOption(Icons.send, '또는'),
        ],
      ),
    );
  }

  Widget _buildPhoneAuthOption(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}
