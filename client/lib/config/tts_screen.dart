import 'package:flutter/material.dart';
import 'tts_config.dart'; // TTSConfig 클래스 임포트

class TTSSettingsScreen extends StatefulWidget {
  @override
  _TTSSettingsScreenState createState() => _TTSSettingsScreenState();
}

class _TTSSettingsScreenState extends State<TTSSettingsScreen> {
  final TTSConfig ttsConfig = TTSConfig();
  final TextEditingController _testController = TextEditingController();

  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 1.0;

  String? _selectedVoice;
  List<dynamic> _voices = [];

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  Future<void> _initSettings() async {
    await ttsConfig.initTTS();
    _voices = ttsConfig.voices;
    setState(() {
      _speechRate = ttsConfig.speechRate;
      _pitch = ttsConfig.pitch;
      _volume = ttsConfig.volume;
      _selectedVoice = ttsConfig.selectedVoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TTS 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('말하기 속도', style: TextStyle(fontSize: 18)),
            Slider(
              value: _speechRate,
              min: 0.1,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _speechRate = value;
                  ttsConfig.setSpeechRate(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text('피치', style: TextStyle(fontSize: 18)),
            Slider(
              value: _pitch,
              min: 0.5,
              max: 2.0,
              onChanged: (value) {
                setState(() {
                  _pitch = value;
                  ttsConfig.setPitch(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text('볼륨', style: TextStyle(fontSize: 18)),
            Slider(
              value: _volume,
              min: 0.0,
              max: 2.0,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                  ttsConfig.setVolume(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text('목소리', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _selectedVoice,
              isExpanded: true,
              items: _voices.map<DropdownMenuItem<String>>((dynamic voice) {
                return DropdownMenuItem<String>(
                  value: voice['name'],
                  child: Text(voice['name'] ?? ''),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedVoice = newValue;
                  ttsConfig.setVoice(newValue!);
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _testController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '테스트 말하기 텍스트 입력',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final text = _testController.text;
                if (text.isNotEmpty) {
                  ttsConfig.speak(text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('먼저 텍스트를 입력하세요')),
                  );
                }
              },
              child: Text('TTS 테스트'),
            ),
          ],
        ),
      ),
    );
  }
}