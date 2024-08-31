import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';

//void main() => runApp(const SpeechSampleApp());

class SpeechSampleApp extends StatefulWidget {
  const SpeechSampleApp({Key? key}) : super(key: key);

  @override
  State<SpeechSampleApp> createState() => _SpeechSampleAppState();
}

class _SpeechSampleAppState extends State<SpeechSampleApp> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;
  final TextEditingController _pauseForController = TextEditingController(text: '5');
  final TextEditingController _listenForController = TextEditingController(text: '10');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initSpeechState();
    _audioPlayer.onPlayerComplete.listen((event) {
      startListening();
    });
    _audioPlayer.play(AssetSource('sounds/13.mp3'));
  }

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        _localeNames = await speech.locales();
        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE8F5E9),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();},
                    child: Text("돌아가기")),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '어떤 도움이',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '필요하신가요',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTapDown: (_) => startListening(),
                        onTapUp: (_) => stopListening(),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.mic,
                            size: 48,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        '예시:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '돈 보내줘',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '들은 내용:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lastWords,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
    }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    final options = SpeechListenOptions(
      onDevice: _onDevice,
      listenMode: ListenMode.confirmation,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    );
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';

      // "보내"라는 단어가 포함되어 있는지 체크
      if (lastWords.contains("보내")) {
        _logEvent('Detected the word "보내"');
        cancelListening();
        // 필요한 동작을 수행합니다.
        // 예: 메시지를 전송하거나 다른 로직을 실행할 수 있습니다.
        _showConfirmationDialog(context);
      }
    });
  }
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('확인'),
          content: Text('정말 이 작업을 수행하시겠습니까?'),
          actions: [
            TextButton(
              child: Text('아니오'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountInfoInputScreen(),
                    // 필요한 경우 여기에 인자를 추가로 전달
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent('Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent('Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
      }
    );
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      print(eventDescription);
    }
  }
}

class VoiceInputScreen extends StatelessWidget {
  const VoiceInputScreen({Key? key, required this.lastWords, required this.level}) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 도움이 필요하',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '신가요',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(Icons.mic, size: 50, color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
              Text(
                '예시:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '며느리한테 돈을',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '불일래',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '들은 내용:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              RecognitionResultsWidget(lastWords: lastWords, level: level),
            ],
          ),
        ),
      ),
    );
  }
}
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({Key? key, required this.lastWords, required this.level}) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('들은 내용: ', style: TextStyle(fontSize: 22.0)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              child: Text(lastWords, style: const TextStyle(fontSize: 32.0)),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: .26,
                    spreadRadius: level * 1.5,
                    color: Colors.black.withOpacity(.05),
                  )
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}