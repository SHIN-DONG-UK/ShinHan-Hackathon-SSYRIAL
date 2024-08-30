import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// speech_to_text 패키지에서 오류 관련 클래스 임포트
import 'package:speech_to_text/speech_recognition_error.dart';
// speech_to_text 패키지에서 인식 결과 관련 클래스 임포트
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() => runApp(const SpeechSampleApp());

class SpeechSampleApp extends StatefulWidget {
  // 생성자 정의, const 키워드는 위젯이 불변임을 나타냄
  const SpeechSampleApp({Key? key}) : super(key: key);

  // _SpeechSampleAppState의 상태를 관리하는 메서드
  @override
  State<SpeechSampleApp> createState() => _SpeechSampleAppState();
}

// 애플리케이션의 상태 클래스 정의
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  // 음성 인식 기능의 사용 가능 여부를 나타내는 변수 -> 필요(init 하고나서 업데이트됨)
  bool _hasSpeech = false;
  // 이벤트 로깅 여부를 나타내는 변수 -> 불필요( 로깅이 기능에 사용되지 않음 )
  bool _logEvents = false;
  // 디바이스 내 음성 인식을 사용할지 여부를 나타내는 변수 -> 불필요( 디바이스에서 나오는 음성은 무시해야 함 )
  bool _onDevice = false;
  // 'pause for' 값 입력을 위한 텍스트 컨트롤러, 기본값 3 -> 필요( 초기에 세팅값으로 지정 )
  final TextEditingController _pauseForController = TextEditingController(text: '3');
  // 'listen for' 값 입력을 위한 텍스트 컨트롤러, 기본값 30 -> 필요( 몇 초동안 들을건지 )
  final TextEditingController _listenForController = TextEditingController(text: '30');
  // 음성 인식 레벨을 나타내는 변수 -> 들리는 소리의 레벨을 지정하는 파라미터 -> 필요( 이게 0이면 못들음 )
  double level = 0.0;
  // 최소 음성 레벨을 나타내는 변수 -> 필요( 뭔가 필요한듯 )
  double minSoundLevel = 50000;
  // 최대 음성 레벨을 나타내는 변수 -> 필요( 뭔가 필요해 보임 )
  double maxSoundLevel = -50000;
  // 마지막으로 인식된 단어를 저장하는 문자열 변수 -> 필요( STT 결과를 쌓는데 필요 )
  String lastWords = '';
  // 마지막 오류 메시지를 저장하는 문자열 변수 -> 불필요( 오류 메시지 저장을 위해 사용 )
  String lastError = '';
  // 마지막 상태 메시지를 저장하는 문자열 변수 -> 일단 필요( listening, notlistening, done 세가지 상태 )
  String lastStatus = '';
  // 현재 선택된 로케일 ID를 저장하는 문자열 변수 -> 필요( 언어 선택임, 근데 시스템 로케일을 알아서 가져옴 )
  String _currentLocaleId = '';
  // 지원되는 로케일 목록을 저장하는 리스트 -> 필요( 일단 로케일 목록 가져오는거니까 )
  List<LocaleName> _localeNames = [];
  // SpeechToText 클래스의 인스턴스 생성 -> 무조건 필요( 이 인스턴스를 사용해서 함수 사용해야 함 )
  final SpeechToText speech = SpeechToText();

  // 위젯이 생성될 때 호출되는 메서드, 초기화 작업을 수행
  @override
  void initState() {
    super.initState();
  }

  // 음성 인식 기능 초기화를 위한 비동기 메서드
  Future<void> initSpeechState() async {
    // 초기화 이벤트를 로깅
    _logEvent('Initialize');
    try {
      // 음성 인식 기능을 초기화하고 결과를 hasSpeech 변수에 저장
      var hasSpeech = await speech.initialize(
        onError: errorListener, // 오류 발생 시 호출되는 콜백 함수
        onStatus: statusListener, // 상태 변경 시 호출되는 콜백 함수
        debugLogging: _logEvents, // 디버그 로깅 여부
      );
      if (hasSpeech) { // 음성 인식 기능이 사용 가능하다면
        // 지원되는 로케일 목록을 가져와 저장
        _localeNames = await speech.locales();
        // 시스템의 기본 로케일을 가져와 저장
        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? ''; // 로케일 ID 설정
      }
      if (!mounted) return; // 위젯이 여전히 마운트되어 있는지 확인

      // 상태를 변경하여 UI를 갱신
      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) { // 오류가 발생하면
      setState(() { // 상태를 변경하여 오류 메시지 표시
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false; // 음성 인식 기능 비활성화
      });
    }
  }

  // UI를 구축하는 메서드
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech to Text Example'), // 앱의 제목 설정
        ),
        body: Column(children: [ // 메인 화면의 UI 구성
          const HeaderWidget(), // 헤더 위젯 추가
          Column(
            children: <Widget>[
              InitSpeechWidget(_hasSpeech, initSpeechState), // 초기화 버튼 위젯
              SpeechControlWidget(_hasSpeech, speech.isListening,
                  startListening, stopListening, cancelListening), // 음성 인식 제어 버튼 위젯
              SessionOptionsWidget( // 세션 옵션 설정 위젯
                _currentLocaleId,
                _switchLang,
                _localeNames,
                _logEvents,
                _switchLogging,
                _pauseForController,
                _listenForController,
                _onDevice,
                _switchOnDevice,
              ),
            ],
          ),
          Expanded( // 인식 결과를 표시하는 위젯
            flex: 4,
            child: RecognitionResultsWidget(lastWords: lastWords, level: level),
          ),
          Expanded( // 오류 메시지를 표시하는 위젯
            flex: 1,
            child: ErrorWidget(lastError: lastError),
          ),
          SpeechStatusWidget(speech: speech), // 음성 인식 상태를 표시하는 위젯
        ]),
      ),
    );
  }

  // 음성 인식 세션을 시작하는 메서드
  void startListening() {
    _logEvent('start listening'); // 시작 이벤트 로깅
    lastWords = ''; // 마지막 단어 초기화
    lastError = ''; // 마지막 오류 초기화
    final pauseFor = int.tryParse(_pauseForController.text); // 'pause for' 값 가져오기
    final listenFor = int.tryParse(_listenForController.text); // 'listen for' 값 가져오기
    final options = SpeechListenOptions( // 음성 인식 옵션 설정
        onDevice: _onDevice,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true);
    // 음성 인식 시작, 결과 및 오류 처리 콜백 함수 지정
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
    setState(() {}); // 상태를 갱신하여 UI 업데이트
  }

  // 음성 인식을 중지하는 메서드
  void stopListening() {
    _logEvent('stop'); // 중지 이벤트 로깅
    speech.stop(); // 음성 인식 중지
    setState(() {
      level = 0.0; // 소리 레벨 초기화
    });
  }

  // 음성 인식을 취소하는 메서드
  void cancelListening() {
    _logEvent('cancel'); // 취소 이벤트 로깅
    speech.cancel(); // 음성 인식 취소
    setState(() {
      level = 0.0; // 소리 레벨 초기화
    });
  }

  // 음성 인식 결과가 있을 때 호출되는 콜백 함수
  void resultListener(SpeechRecognitionResult result) {
    _logEvent( // 결과 이벤트 로깅
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}'; // 인식된 단어 업데이트
    });
  }

  // 소리 레벨이 변경될 때 호출되는 콜백 함수
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level); // 최소 소리 레벨 업데이트
    maxSoundLevel = max(maxSoundLevel, level); // 최대 소리 레벨 업데이트
    setState(() {
      this.level = level; // 현재 소리 레벨 업데이트
    });
  }

  // 오류가 발생했을 때 호출되는 콜백 함수
  void errorListener(SpeechRecognitionError error) {
    _logEvent( // 오류 이벤트 로깅
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error

          .permanent}'; // 오류 메시지 업데이트
    });
  }

  // 상태가 변경되었을 때 호출되는 콜백 함수
  void statusListener(String status) {
    _logEvent( // 상태 이벤트 로깅
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status'; // 상태 메시지 업데이트
    });
  }

  // 로케일을 변경하는 메서드
  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal; // 현재 로케일 ID 업데이트

    });
    _logEvent('switchLang to $selectedVal'); // 로케일 변경 이벤트 로깅
  }

  // 이벤트 로깅 여부를 변경하는 메서드
  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false; // 이벤트 로깅 여부 업데이트
    });
  }

  // 디바이스 내 음성 인식 사용 여부를 변경하는 메서드
  void _switchOnDevice(bool? val) {
    setState(() {
      _onDevice = val ?? false; // 디바이스 내 음성 인식 사용 여부 업데이트
    });
  }

  // 이벤트를 로깅하는 메서드
  void _logEvent(String eventDescription) {
    if (_logEvents) { // 이벤트 로깅이 활성화되어 있을 때만 로그 출력
      // 무시할 수 있는 디버그 코드
      print(eventDescription);
    }
  }
}

// 헤더 위젯 정의
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Center(
          child: Text('Speech to Text Example'),
        ),
      ],
    );
  }
}

// 음성 인식 초기화 버튼 위젯 정의
class InitSpeechWidget extends StatelessWidget {
  // 음성 인식 기능의 사용 가능 여부와 초기화 메서드를 전달받음
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final VoidCallback initSpeechState;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        const Text('Initialize'),
        IconButton(
          icon: const Icon(Icons.settings_voice),
          onPressed: !hasSpeech ? initSpeechState : null,
        ),
      ]),
    ]);
  }
}

// 음성 인식 제어 버튼 위젯 정의
class SpeechControlWidget extends StatelessWidget {
  // 생성자에서 필요한 값들을 전달받음
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final VoidCallback startListening;
  final VoidCallback stopListening;
  final VoidCallback cancelListening;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            child: const Text('Start'),
            onPressed: !hasSpeech || isListening ? null : startListening,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            child: const Text('Stop'),
            onPressed: isListening ? stopListening : null,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            child: const Text('Cancel'),
            onPressed: isListening ? cancelListening : null,
          ),
        ),
      ]),
    ]);
  }
}

// 세션 옵션 설정 위젯 정의
class SessionOptionsWidget extends StatelessWidget {
  // 생성자에서 필요한 값들을 전달받음
  const SessionOptionsWidget(
      this.currentLocaleId,
      this.switchLang,
      this.localeNames,
      this.logEvents,
      this.switchLogging,
      this.pauseForController,
      this.listenForController,
      this.onDevice,
      this.switchOnDevice,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final List<LocaleName> localeNames;
  final bool logEvents;
  final void Function(bool?) switchLogging;
  final TextEditingController pauseForController;
  final TextEditingController listenForController;
  final bool onDevice;
  final void Function(bool?) switchOnDevice;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        const Text('Language: '),
        DropdownButton<String>(
          onChanged: (selectedVal) => switchLang(selectedVal),
          value: currentLocaleId,
          items: localeNames
              .map(
                (localeName) => DropdownMenuItem(
              value: localeName.localeId,
              child: Text(localeName.name),
            ),
          )
              .toList(),
        ),
      ]),
      Row(children: [
        const Text('pauseFor: '),
        Container(
            padding: const EdgeInsets.only(left: 8.0),
            width: 80,
            child: TextField(
              controller: pauseForController,
            )),
        Container(
          padding: const EdgeInsets.only(left: 16),
          child: const Text('listenFor: '),
        ),
        Container(
            padding: const EdgeInsets.only(left: 8.0),
            width: 80,
            child: TextField(
              controller: listenForController,
            )),
      ]),
      Row(children: [
        const Text('On device: '),
        Checkbox(
          value: onDevice,
          onChanged: switchOnDevice,
        ),
        const Text('Log events: '),
        Checkbox(
          value: logEvents,
          onChanged: switchLogging,
        ),
      ]),
    ]);
  }
}

// 인식 결과를 표시하는 위젯 정의
class RecognitionResultsWidget extends StatelessWidget {
  // 생성자에서 인식 결과와 레벨 값을 전달받음
  const RecognitionResultsWidget(
      {Key? key, required this.lastWords, required this.level})
      : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Recognized Words',
            style: TextStyle(fontSize: 22.0)),
        Expanded(
          child: Stack(
            children: [
              Container(
                child: Text(lastWords,
                    style: const TextStyle(fontSize: 32.0)),
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: .26,
                              spreadRadius: level * 1.5,
                              color: Colors.black.withOpacity(.05))
                        ],
                        color: Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// 오류 메시지를 표시하는 위젯 정의
class ErrorWidget extends StatelessWidget {
  // 생성자에서 오류 메시지를 전달받음
  const ErrorWidget({Key? key, required this.lastError}) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(lastError),
    );
  }
}

// 음성 인식 상태를 표시하는 위젯 정의
class SpeechStatusWidget extends StatelessWidget {
  // 생성자에서 SpeechToText 인스턴스를 전달받음
  const SpeechStatusWidget({Key? key, required this.speech}) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: speech.isListening
            ? const Text(
          "I'm listening...",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
            : const Text(
          'Not listening',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}