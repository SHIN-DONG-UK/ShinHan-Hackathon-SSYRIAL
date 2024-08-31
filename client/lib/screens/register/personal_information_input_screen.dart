import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
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
  bool _isLoading = false; // 로딩 상태
  final Dio _dio = Dio();

  // 정규식 패턴
  final RegExp _nameRegExp = RegExp(r'^[가-힣]{2,}$'); // 한글만 최소 2자 이상
  final RegExp _birthdayRegExp = RegExp(r'^\d{6}$'); // 6자리 숫자

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
              fontSize: kTitleFontSize,
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
                fontSize: kTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: kPadding),
            _buildBirthdayInputSection(), // 생년월일 입력 필드
          ],

          if (_isBirthdayFieldEnabled && _isAuthenticateButtonEnabled) ...[
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
      _isBirthdayFieldEnabled = _nameRegExp.hasMatch(value); // 이름 정규식 검증 후 생년월일 필드 활성화
    });
  }

  // 생년월일 입력 필드 변경 시 호출
  void _onBirthdayChanged(String value) {
    setState(() {
      _isAuthenticateButtonEnabled = _birthdayRegExp.hasMatch(value); // 생년월일 정규식 검증 후 인증 버튼 활성화
    });
  }

  // userId 생성 로직
  String _generateUserId() {
    String name = _nameController.text.trim().toLowerCase();
    String numericName = convertHangulToNumber(name);
    String birthday = _birthdayController.text.trim();
    return "$birthday$numericName@ssafy.com";
  }

  // 인증 요청 메서드
  Future<void> _authenticate() async {
    setState(() {
      _isLoading = true;
    });

    String userId = _generateUserId(); // userId 생성

    try {
      final response = await _dio.post(
        'https://port-0-shinhan-hackathon-ssyrial-ss7z32llwg3l2ao.sel5.cloudtype.app/api/member/login', // 새 API 엔드포인트
        data: {
          'userId': userId, // 생성한 userId 전송
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        widget.onAuthenticationSuccess(); // 인증 성공 시 콜백 호출
        context.showResultPopup('성공했습니다'); // 성공 팝업
      } else {
        context.showResultPopup('실패했습니다'); // 실패 팝업
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      context.showResultPopup('실패했습니다: $e'); // 예외 발생 시 실패 팝업
    }
  }
}

// 위젯을 구성하는 메서드를 확장 메서드로 분리하여 구조화
extension WidgetExtensions on _PersonalInformationInputScreenState {
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
          Text('이름', style: TextStyle(fontSize: kButtonFontSize)),
          SizedBox(height: kPadding / 2),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: '입력해 주세요.',
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
          Text('생년월일', style: TextStyle(fontSize: kButtonFontSize)),
          SizedBox(height: kPadding / 2),
          TextField(
            controller: _birthdayController,
            decoration: InputDecoration(
              hintText: 'ooMMDD',
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
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 열려있는 입력창 닫기
          _authenticate();
          context.showLoadingPopup(); // 로딩 팝업 표시
        },
        child: Text(
          '인증하기',
          style: TextStyle(fontSize: kButtonFontSize),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
        ),
      ),
    );
  }
}

// 유틸리티 함수들을 확장 메서드로 분리하여 코드 간소화
extension ContextExtensions on BuildContext {
  // 인증 결과 팝업 표시
  void showResultPopup(String message) {
    Navigator.of(this).pop(); // 로딩중 팝업 제거
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('인증 결과', style: TextStyle(fontSize: kTitleFontSize)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인', style: TextStyle(fontSize: kButtonFontSize)),
            ),
          ],
        );
      },
    );
  }

  // 로딩 중 팝업 표시
  void showLoadingPopup() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: kPadding),
              Text("확인중입니다.....", style: TextStyle(fontSize: kButtonFontSize)),
            ],
          ),
        );
      },
    );
  }
}

String convertHangulToNumber(String name) {
  StringBuffer numberBuffer = StringBuffer();

  for (int i = 0; i < name.length; i++) {
    int codeUnit = name.codeUnitAt(i);

    if (codeUnit >= 0xAC00 && codeUnit <= 0xD7A3) {
      // 한글 음절
      int baseCode = codeUnit - 0xAC00;

      int jongseongIndex = baseCode % 28; // 종성 인덱스
      int jungseongIndex = ((baseCode - jongseongIndex) / 28).toInt() % 21; // 중성 인덱스
      int choseongIndex = (((baseCode - jongseongIndex) / 28).toInt() / 21).toInt(); // 초성 인덱스

      // 초성, 중성, 종성을 각각 숫자로 변환하여 붙이기
      numberBuffer.write((choseongIndex + 1).toString().padLeft(2, '0'));
      numberBuffer.write((jungseongIndex + 1).toString().padLeft(2, '0'));
      numberBuffer.write((jongseongIndex + 1).toString().padLeft(2, '0'));
    } else {
      // 한글이 아닌 경우 해당 문자 그대로 추가 (예: 영어, 숫자)
      numberBuffer.write(codeUnit.toString());
    }
  }

  return numberBuffer.toString();
}
