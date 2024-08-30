import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainSTTScreen(),
    );
  }
}

class MainSTTScreen extends StatefulWidget {
  const MainSTTScreen({Key? key}) : super(key: key);

  @override
  _MainSTTScreenState createState() => _MainSTTScreenState();
}

class _MainSTTScreenState extends State<MainSTTScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false; // 음성 인식이 활성화 되었는지 여부
  bool _isListening = false; // 현재 음성 인식을 듣고 있는지 여부
  String _lastWords = '';
  String _statusMessage = "음성 인식이 준비되지 않았습니다."; // 상태 메시지 추가

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (status) {
        // 상태 업데이트를 위한 콜백
        setState(() {
          _statusMessage = '상태: $status';
        });
      },
      onError: (errorNotification) {
        // 오류 발생 시 처리
        setState(() {
          _statusMessage = '오류: ${errorNotification.errorMsg}';
        });
      },
    );
    if (_speechEnabled) {
      setState(() {
        _statusMessage = "음성 인식이 활성화되었습니다.";
      });
    } else {
      setState(() {
        _statusMessage = "음성 인식 초기화에 실패했습니다.";
      });
    }
  }

  void _startListening() async {
    if (_speechEnabled && !_isListening) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {
        _isListening = true;
        _statusMessage = "음성 인식 중...";
      });
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
        _statusMessage = "음성 인식이 중지되었습니다.";
      });
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _statusMessage = "음성 인식이 완료되었습니다.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _statusMessage, // 상태 메시지 표시
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
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
                      '어떤 도움이 필요하신가요',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTapDown: (_) => _startListening(), // 음성 인식 시작
                      onTapUp: (_) => _stopListening(), // 음성 인식 중지
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: _isListening
                              ? Colors.red[300]
                              : Colors.grey[200], // 청취 중일 때 색상 변경
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
                      '며느리한테 돈을 빌릴래',
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
                            _lastWords, // 인식된 단어 표시
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
    );
  }
}
