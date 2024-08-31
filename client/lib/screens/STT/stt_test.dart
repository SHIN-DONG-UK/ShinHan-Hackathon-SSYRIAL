import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';

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

  String _currentVoiceScript = ''; // Text to display
  List<String> _audioQueue = ['sounds/13.mp3']; // Initial audio file
  List<String> _scriptQueue = ["휴대폰에 대고\n 돈 보내기라고 해보세요"]; // Corresponding text
  int _currentAudioIndex = 0;

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
      startListening(); // Start listening after the audio completes
    });
    _playVoiceForCurrentScreen(); // Play initial audio
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
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("돌아가기"),
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
                          '돈 보내기',
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
              Positioned(
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/moli.gif', // Replace with your asset path
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _currentVoiceScript, // Display the current voice script
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
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
      lastWords = result.recognizedWords;

      // "보내"라는 단어가 포함되어 있는지 체크
      if (lastWords.contains("보내")) {
        _logEvent('Detected the word "보내"');
        cancelListening();
        _showSuccessPopup(context, "돈 보내기가 인식되었습니다!");
      }
    });
  }

  void _showSuccessPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return SuccessPopup(
          message: message, // Pass the custom message
          onComplete: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountInfoInputScreen(),
                // Pass additional arguments if needed
              ),
            );
          },
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
    });
  }

  void _playVoiceForCurrentScreen() {
    if (_currentAudioIndex < _audioQueue.length) {
      setState(() {
        _currentVoiceScript = _scriptQueue[_currentAudioIndex]; // Update the text
      });
      _audioPlayer.play(AssetSource(_audioQueue[_currentAudioIndex]));
      _currentAudioIndex++;
    }
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      print(eventDescription);
    }
  }
}

class SuccessPopup extends StatefulWidget {
  final String message; // Message to display in the popup
  final VoidCallback onComplete;

  const SuccessPopup({
    Key? key,
    required this.message, // Required parameter for the message
    required this.onComplete,
  }) : super(key: key);

  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.8; // 80% of screen width

    return ScaleTransition(
      scale: _animation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: dialogWidth,
          padding: const EdgeInsets.all(24), // Larger padding
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24), // Extra top margin
              Container(
                padding: const EdgeInsets.all(24), // Increase inner padding
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80, // Larger icon size
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 50, // Increase icon size
                      ),
                    ),
                    const SizedBox(height: 24), // Increase space between icon and text
                    Text(
                      widget.message, // Display custom message
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increase font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Extra bottom margin
              ElevatedButton(
                onPressed: widget.onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Set the background color to green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '완료',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
