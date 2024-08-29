import 'package:flutter/material.dart';
import 'constants.dart';

class PersonalInfoConsentScreen extends StatelessWidget {
  final List<bool> isChecked;
  final ValueChanged<List<bool>> onCheckedChanged;

  const PersonalInfoConsentScreen({
    required this.isChecked,
    required this.onCheckedChanged,
  });

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
          Text(
            '회원 등록을 위해\n항목에 동의해주세요.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < _consentTexts.length; i++)
            _buildConsentItem(_consentTexts[i], i),
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
            value: isChecked[index],
            onChanged: (bool? value) {
              List<bool> newCheckedValues = List.from(isChecked);
              newCheckedValues[index] = value ?? false;
              if (index == 0) {
                newCheckedValues.fillRange(1, newCheckedValues.length, value ?? false);
              } else {
                newCheckedValues[0] = newCheckedValues.sublist(1).every((element) => element);
              }
              onCheckedChanged(newCheckedValues);
            },
          ),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  static const List<String> _consentTexts = [
    '필수 항목 전체 동의',
    '[필수] 개인정보 수집이용',
    '[필수] 고유식별정보처리 동의',
    '[필수] 통신사 이용약관',
    '[필수] 서비스 이용 동의',
  ];
}
