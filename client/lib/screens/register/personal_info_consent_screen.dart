import 'package:flutter/material.dart';
import '../../config/constants.dart';

class PersonalInfoConsentScreen extends StatefulWidget {
  final ValueChanged<bool> onAllConsentsChecked; // 모든 항목이 체크되었는지 전달하는 콜백

  const PersonalInfoConsentScreen({Key? key, required this.onAllConsentsChecked})
      : super(key: key);

  @override
  _PersonalInfoConsentScreenState createState() =>
      _PersonalInfoConsentScreenState();
}

class _PersonalInfoConsentScreenState extends State<PersonalInfoConsentScreen> {

  static const List<String> _consentTexts = [
    '필수 항목 전체 동의',
    '[필수] 개인정보 수집이용',
    '[필수] 고유식별\n정보처리 동의',
    '[필수] 통신사 이용약관',
    '[필수] 서비스 이용 동의',
  ];

  List<bool> _isChecked = List.filled(5, false); // 내부에서 체크 상태 관리

  @override
  void initState() {
    super.initState();
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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ..._consentTexts.asMap().entries.map(
                (entry) => _buildConsentItem(entry.value, entry.key),
          ),
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
            value: _isChecked[index],
            onChanged: (bool? value) => _updateConsentState(index, value ?? false),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 25), // 원하는 글자 크기 설정
          ),
        ],
      ),
    );
  }


  void _updateConsentState(int index, bool value) {
    setState(() {
      if (index == 0) {
        // '필수 항목 전체 동의'를 선택했을 때, 모든 항목의 체크 상태를 변경
        _isChecked.fillRange(0, _isChecked.length, value);
      } else {
        // 개별 항목의 체크 상태를 변경
        _isChecked[index] = value;
        // 개별 항목 중 하나라도 체크가 해제되면 '필수 항목 전체 동의' 체크 해제
        _isChecked[0] = _isChecked.sublist(1).every((element) => element);
      }
      // 모든 항목이 체크되었는지 여부를 콜백을 통해 전달
      widget.onAllConsentsChecked(_isChecked.every((element) => element));
    });
  }
}
