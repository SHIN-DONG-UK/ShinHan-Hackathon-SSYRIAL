import 'package:flutter/material.dart';
import 'package:ssyrial/config/tts_config.dart';
import 'package:ssyrial/config/constants.dart';

class StartScreen extends StatefulWidget {
  final VoidCallback onTTSComplete;

  const StartScreen({required this.onTTSComplete});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TTSConfig ttsConfig = TTSConfig();

  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage();
  }

  Future<void> _speakWelcomeMessage() async {
    await ttsConfig.initTTS(); // Initialize TTS settings
    ttsConfig.flutterTts.setCompletionHandler(() {
      widget.onTTSComplete(); // Move to the next screen when TTS is done
    });
    await ttsConfig.speak("시작하기 위해 회원 등록을 진행할게요."); // Speak the welcome message
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
            '시작하기 위해\n회원 등록을\n진행할게요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: kTitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
