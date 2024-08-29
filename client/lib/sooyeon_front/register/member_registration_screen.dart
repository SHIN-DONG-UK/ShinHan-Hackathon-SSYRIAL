import 'package:flutter/material.dart';

import '../1-2.cancle_member_registration.dart';
import '../4.personal_information_all_consent.dart';

// 상수 정의
const double kPadding = 20.0; // 전체 Padding
const double kButtonFontSize = 18.0; // 버튼 폰트 크기
const double kTitleFontSize = 24.0; // 제목 폰트 크기
const double kContainerPadding = 20.0; // 컨테이너 Padding
const double kButtonPaddingVertical = 15.0; // 버튼 수직 Padding
const double kButtonPaddingHorizontal = 50.0; // 버튼 수평 Padding

const Color kScaffoldBackgroundColor = Color(0xFFFFF0F5); // Scaffold 배경색
const Color kContainerBackgroundColor = Colors.white; // 컨테이너 배경색
const Color kCancelButtonColor = Color(0xFFD3D3D3); // 취소 버튼 색상
const Color kNextButtonColor = Colors.green; // 다음 버튼 색상

const BorderRadius kButtonBorderRadius = BorderRadius.all(Radius.circular(25)); // 버튼 모서리 둥글기
const BorderRadius kContainerBorderRadius = BorderRadius.all(Radius.circular(15)); // 컨테이너 모서리 둥글기

// 화면 상태를 관리하는 Enum
enum ScreenState {
  start, // 시작 화면
  phoneAuth, // 전화 인증 화면
  personalInfoConsent, // 개인정보 동의 화면
}

class MemberRegistrationStartScreen extends StatefulWidget {
  const MemberRegistrationStartScreen({super.key});

  @override
  _MemberRegistrationStartScreenState createState() => _MemberRegistrationStartScreenState();
}

class _MemberRegistrationStartScreenState extends State<MemberRegistrationStartScreen> {
  ScreenState _currentScreen = ScreenState.start; // 현재 화면 상태
  List<bool> _isChecked = [false, false, false, false, false]; // 체크박스 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCancelButton(context), // 취소 버튼
              const SizedBox(height: 20),
              Expanded(
                child: _buildScreenContainer(), // 현재 화면에 따라 컨테이너 빌드
              ),
              if (_canProceed()) _buildNextButton(context), // 다음 버튼
            ],
          ),
        ),
      ),
    );
  }

  // 다음 버튼 눌렀을 때의 동작
  void _onNextPressed(BuildContext context) {
    setState(() {
      switch (_currentScreen) {
        case ScreenState.start:
          _currentScreen = ScreenState.phoneAuth; // 전화 인증 화면으로 전환
          break;
        case ScreenState.phoneAuth:
          _currentScreen = ScreenState.personalInfoConsent; // 개인정보 동의 화면으로 전환
          break;
        case ScreenState.personalInfoConsent:
          if (_isChecked[0]) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalInformationAllConsent(isAllConsented: true),
              ),
            );
          }
          break;
      }
    });
  }

  // 취소 버튼 눌렀을 때의 동작
  void _onCancelPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CancelMemberRegistrationScreen(),
      ),
    );
  }

  // 버튼 활성화 여부를 체크하는 메서드
  bool _canProceed() {
    if (_currentScreen == ScreenState.personalInfoConsent) {
      return _isChecked[0]; // 개인정보 동의가 완료된 경우에만 진행 가능
    }
    return true; // 다른 화면에서는 기본적으로 활성화
  }
}

// `MemberRegistrationStartScreen` 클래스에 대한 `extension` 정의
extension MemberRegistrationWidgets on _MemberRegistrationStartScreenState {
  // 공통 액션 버튼 위젯 빌드
  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: kButtonBorderRadius,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: kButtonFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // 취소 버튼 위젯
  Widget _buildCancelButton(BuildContext context) {
    return _buildActionButton(
      label: '취소하기',
      color: kCancelButtonColor,
      onPressed: () => _onCancelPressed(context),
    );
  }

  // 다음 버튼 위젯
  Widget _buildNextButton(BuildContext context) {
    return _buildActionButton(
      label: '다음',
      color: kNextButtonColor,
      onPressed: () => _onNextPressed(context),
    );
  }

  // 현재 화면에 따라 컨테이너를 빌드
  Widget _buildScreenContainer() {
    switch (_currentScreen) {
      case ScreenState.start:
        return _buildStartContainer(); // 시작 화면 컨테이너
      case ScreenState.phoneAuth:
        return _buildPhoneAuthContainer(); // 전화 인증 화면 컨테이너
      case ScreenState.personalInfoConsent:
        return _buildPersonalInfoConsentContainer(); // 개인정보 동의 화면 컨테이너
      default:
        return Container();
    }
  }

  // 시작 화면 컨테이너 빌드
  Widget _buildStartContainer() {
    return _buildContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '시작하기 위해\n회원 등록을\n진행할게요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: kTitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 전화 인증 화면 컨테이너 빌드
  Widget _buildPhoneAuthContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '번호 인증을 위해\n문자를 보내주세요.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        _buildPhoneAuthOption(Icons.message, '메시지'),
        SizedBox(height: 10),
        _buildPhoneAuthOption(Icons.send, '또는'),
      ],
    );
  }

  // 전화 인증 옵션 위젯 빌드
  Widget _buildPhoneAuthOption(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }

  // 개인정보 동의 화면 컨테이너 빌드
  Widget _buildPersonalInfoConsentContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '회원 등록을 위해\n항목에 동의해주세요.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildConsentItem('필수 항목 전체 동의', 0),
        _buildConsentItem('[필수] 개인정보 수집이용', 1),
        _buildConsentItem('[필수] 고유식별정보처리 동의', 2),
        _buildConsentItem('[필수] 통신사 이용약관', 3),
        _buildConsentItem('[필수] 서비스 이용 동의', 4),
      ],
    );
  }

  // 개인정보 동의 항목 위젯 빌드
  Widget _buildConsentItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[index],
            onChanged: (bool? value) {
              setState(() {
                _isChecked[index] = value!;
                // 전체 동의 체크박스 선택 시 나머지 항목 자동 선택
                if (index == 0) {
                  _isChecked.fillRange(1, _isChecked.length, value);
                } else {
                  // 개별 항목 선택 시 전체 동의 체크박스 상태 변경
                  _isChecked[0] = _isChecked.sublist(1).every((element) => element);
                }
              });
            },
          ),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  // 공통 컨테이너 위젯 빌드
  Widget _buildContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(kContainerPadding),
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: kContainerBorderRadius,
      ),
      child: child,
    );
  }
}
