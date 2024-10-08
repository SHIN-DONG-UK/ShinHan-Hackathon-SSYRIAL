import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:ssyrial/config/global_state.dart';
import 'package:ssyrial/widgets/POPUP_fail.dart';
import 'package:ssyrial/widgets/POPUP_success.dart';
import '../../config/constants.dart';

class PhoneAuthScreen extends StatefulWidget {
  final VoidCallback onSendButtonPressed;

  PhoneAuthScreen({required this.onSendButtonPressed});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isSendButtonEnabled = false; // 전송 버튼 활성화 여부
  bool _isLoading = false; // 로딩 상태
  final Dio _dio = Dio();

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '핸드폰 번호를 입력해주세요.',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kPadding),
          _buildPhoneInputSection(), // 핸드폰 번호 입력 필드
          SizedBox(height: kPadding),
          if (_isSendButtonEnabled) _buildSendButton(), // 전송 버튼
          if (_isLoading) CircularProgressIndicator(), // 로딩 인디케이터
        ],
      ),
    );
  }

  // 핸드폰 번호 입력 필드 생성
  Widget _buildPhoneInputSection() {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: kContainerBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('핸드폰 번호', style: TextStyle(fontSize: 24)),
          SizedBox(height: kPadding / 2),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: '01033339999',
              hintStyle: TextStyle(fontSize: 24), // 힌트 텍스트의 폰트 크기 수정
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11), // 핸드폰 번호 최대 11자리
            ],
            onChanged: _onPhoneChanged, // 입력 시 상태 업데이트
          ),
        ],
      ),
    );
  }

  // 핸드폰 번호 입력 필드 변경 시 호출
  void _onPhoneChanged(String value) {
    setState(() {
      _isSendButtonEnabled = value.length == 11; // 11자리 입력 시 전송 버튼 활성화
    });
  }

  // 전송 버튼 생성
  Widget _buildSendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 여백 설정
      child: SizedBox(
        width: double.infinity, // 버튼이 가로로 가득 차도록 설정
        child: ElevatedButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus(); // 열려있는 입력창 닫기
            _sendPhoneNumber();
          },
          child: Text(
            '인증',
            style: TextStyle(fontSize: 40, color: Colors.white), // 하얀색 글자
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // 초록색 배경
            padding: EdgeInsets.symmetric(vertical: 12), // 세로 여백
            shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
          ),
        ),
      ),
    );
  }

  // userId 생성 로직
  String _generateUserId(String phoneNumber) {
    return "$phoneNumber@ssafy.com";
  }

  // 핸드폰 번호 전송 처리 메서드
  Future<void> _sendPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    String phoneNumber = _phoneController.text;
    String userId = _generateUserId(phoneNumber); // userId 생성

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
        // Assuming the response contains a 'userKey'
        final data = response.data;
        GlobalState.userId = data['userId']; // Store userId in global state
        GlobalState.userKey = data['userKey']; // Store userKey in global state

        widget.onSendButtonPressed(); // 인증 성공 시 콜백 호출
        showSuccessPopup(context, '인증에 성공했습니다!'); // 성공 팝업
      } else {
        showPasswordFailPopup(context, '인증에 실패했습니다. 다시 시도해주세요.'); // 실패 팝업
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showPasswordFailPopup(context, '인증에 실패했습니다'); // 예외 발생 시 실패 팝업
    }
  }
}