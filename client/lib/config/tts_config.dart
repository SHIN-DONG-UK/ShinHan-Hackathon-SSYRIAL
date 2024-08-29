import 'package:flutter_tts/flutter_tts.dart';

class TTSConfig {
  static final TTSConfig _instance = TTSConfig._internal();

  factory TTSConfig() {
    return _instance;
  }

  TTSConfig._internal();

  final FlutterTts flutterTts = FlutterTts();

  double speechRate = 0.5;
  double pitch = 1.0;
  double volume = 1.0;
  String? selectedVoice;
  List<dynamic> voices = [];

  Future<void> initTTS() async {
    // Set the default TTS settings
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
    await flutterTts.setLanguage('ko-KR');

    // Get available voices and filter for 'ko-KR'
    List<dynamic> allVoices = await flutterTts.getVoices;
    //voices = allVoices.where((voice) => voice['locale'] == 'ko-KR').toList();
    voices = allVoices;

    print(voices); // Debugging: print filtered voices

    if (voices.isNotEmpty) {
      selectedVoice = voices.first['name'];
      await flutterTts.setVoice({'name': selectedVoice!});
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<void> setSpeechRate(double rate) async {
    speechRate = rate;
    await flutterTts.setSpeechRate(rate);
  }

  Future<void> setPitch(double pitchValue) async {
    pitch = pitchValue;
    await flutterTts.setPitch(pitch);
  }

  Future<void> setVolume(double volumeValue) async {
    volume = volumeValue;
    await flutterTts.setVolume(volume);
  }

  Future<void> setVoice(String voiceName) async {
    selectedVoice = voiceName;
    await flutterTts.setVoice({'name': voiceName});
  }

  Future<List<dynamic>> getVoices() async {
    return voices;
  }
}