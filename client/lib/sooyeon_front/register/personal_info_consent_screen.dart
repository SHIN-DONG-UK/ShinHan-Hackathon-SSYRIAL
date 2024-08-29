import 'package:flutter/material.dart';
import 'package:ssyrial/config/tts_config.dart';
import 'constants.dart';

class PersonalInfoConsentScreen extends StatefulWidget {
  final List<bool> isChecked;
  final ValueChanged<List<bool>> onCheckedChanged;

  const PersonalInfoConsentScreen({
    Key? key,
    required this.isChecked,
    required this.onCheckedChanged,
  }) : super(key: key);

  @override
  _PersonalInfoConsentScreenState createState() => _PersonalInfoConsentScreenState();
}

class _PersonalInfoConsentScreenState extends State<PersonalInfoConsentScreen> {
  final TTSConfig _ttsConfig = TTSConfig();

  static const List<String> _consentTexts = [
    '필수 항목 전체 동의',
    '[필수] 개인정보 수집이용',
    '[필수] 고유식별정보처리 동의',
    '[필수] 통신사 이용약관',
    '[필수] 서비스 이용 동의',
  ];

  @override
  void initState() {
    super.initState();
    _speakConsentMessage();
  }

  Future<void> _speakConsentMessage() async {
    await _ttsConfig.initTTS();
    await _ttsConfig.speak("회원 등록을 위해 항목에 동의해주세요.");
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '회원 등록을 위해\n항목에 동의해주세요.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ..._consentTexts.asMap().entries.map((entry) => _buildConsentItem(entry.value, entry.key)),
        ],
      ),
    );
  }

  Widget _buildConsentItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: widget.isChecked[index],
            onChanged: (bool? value) => _updateConsentState(index, value ?? false),
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  void _updateConsentState(int index, bool value) {
    List<bool> newCheckedValues = List.from(widget.isChecked);
    newCheckedValues[index] = value;
    if (index == 0) {
      newCheckedValues.fillRange(1, newCheckedValues.length, value);
    } else {
      newCheckedValues[0] = newCheckedValues.sublist(1).every((element) => element);
    }
    widget.onCheckedChanged(newCheckedValues);
  }
}