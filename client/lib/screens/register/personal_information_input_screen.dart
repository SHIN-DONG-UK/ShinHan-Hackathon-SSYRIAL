import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssyrial/config/constants.dart';

class PersonalInformationInputScreen extends StatefulWidget {
  final VoidCallback onAuthenticationSuccess;

  // 생성자에서 인증 성공 시 콜백을 받습니다.
  PersonalInformationInputScreen({required this.onAuthenticationSuccess});

  @override
  _PersonalInformationInputScreenState createState() =>
      _PersonalInformationInputScreenState();
}

class _PersonalInformationInputScreenState
    extends State<PersonalInformationInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  bool _isBirthdayFieldEnabled = false; // 생년월일 필드 활성화 여부
  bool _isAuthenticateButtonEnabled = false; // 인증 버튼 활성화 여부

  final RegExp _nameRegExp = RegExp(r'^[가-힣]{2,4}$'); // 한글 이름 정규식 (2-4글자)
  final RegExp _birthdayRegExp = RegExp(r'^\d{6}$'); // 생년월일 정규식 (6자리 숫자)

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
          // 이름 입력 안내 텍스트
          Text(
            '이름을 입력해주세요.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: kPadding),
          _buildNameInputSection(), // 이름 입력 필드

          if (_isBirthdayFieldEnabled) ...[
            SizedBox(height: kPadding),
            // 생년월일 입력 안내 텍스트
            Text(
              '6자리 생년월일을 입력해주세요.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: kPadding),
            _buildBirthdayInputSection(), // 생년월일 입력 필드
          ],

          if (_isAuthenticateButtonEnabled) ...[
            SizedBox(height: kPadding),
            _buildAuthenticateButton(), // 인증 버튼
          ],
        ],
      ),
    );
  }

  // 이름 입력 필드 변경 시 호출
  void _onNameChanged(String value) {
    setState(() {
      _isBirthdayFieldEnabled = _nameRegExp.hasMatch(value); // 이름 정규식 검증
      _validateInputs(); // 입력 유효성 검사
    });
  }

  // 생년월일 입력 필드 변경 시 호출
  void _onBirthdayChanged(String value) {
    setState(() {
      _validateInputs(); // 입력 유효성 검사
    });
  }

  // 입력된 값들이 유효한지 확인하는 메서드
  void _validateInputs() {
    final isNameValid = _nameRegExp.hasMatch(_nameController.text);
    final isBirthdayValid = _birthdayRegExp.hasMatch(_birthdayController.text);
    _isAuthenticateButtonEnabled = isNameValid && isBirthdayValid;
  }

  // 이름 입력 필드 생성
  Widget _buildNameInputSection() {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이름', style: TextStyle(fontSize: 24)),
          SizedBox(height: kPadding / 2),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: '입력해 주세요.',
              hintStyle: TextStyle(fontSize: 24), // 힌트 텍스트의 폰트 크기 수정
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: _onNameChanged, // 입력 시 상태 업데이트
          ),
        ],
      ),
    );
  }

  // 생년월일 입력 필드 생성
  Widget _buildBirthdayInputSection() {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: _isBirthdayFieldEnabled ? Colors.grey[200] : Colors.grey[300],
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('생년월일', style: TextStyle(fontSize: 24)),
          SizedBox(height: kPadding / 2),
          TextField(
            controller: _birthdayController,
            decoration: InputDecoration(
              hintText: 'oo년mm월dd일',
              hintStyle: TextStyle(fontSize: 24), // 힌트 텍스트의 폰트 크기 수정
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            enabled: _isBirthdayFieldEnabled, // 이름이 입력되어야 활성화
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: _onBirthdayChanged, // 입력 시 상태 업데이트
          ),
        ],
      ),
    );
  }

  // 인증 버튼 생성
  Widget _buildAuthenticateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isAuthenticateButtonEnabled ? () {
          FocusManager.instance.primaryFocus?.unfocus(); // 열려있는 입력창 닫기
          widget.onAuthenticationSuccess(); // 다음 단계로 이동
        } : null,
        child: Text(
          '확인',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
        ),
      ),
    );
  }
}
