import 'package:flutter/material.dart';
import 'package:ssyrial/screens/register/personal_info_consent_screen.dart';
import 'package:ssyrial/screens/register/phone_auth_screen.dart';
import 'package:ssyrial/screens/register/start_screen.dart';
import '../../config/constants.dart';
import 'personal_information_input_screen.dart';
import '9.save_your_password.dart';

enum ScreenState {
  start,
  phoneAuth,
  personalInfoConsent,
  personalInfoInput
}

class MemberRegistrationStartScreen extends StatefulWidget {
  const MemberRegistrationStartScreen({Key? key}) : super(key: key);

  @override
  _MemberRegistrationStartScreenState createState() =>
      _MemberRegistrationStartScreenState();
}

class _MemberRegistrationStartScreenState
    extends State<MemberRegistrationStartScreen> {
  ScreenState _currentScreen = ScreenState.start;
  final PageController _pageController = PageController();
  bool _isAuthenticated = false;
  bool _allConsentsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      resizeToAvoidBottomInset: false, // 키보드가 올라와도 화면 크기를 조정하지 않도록 설정
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildActionButton(
                  context, '취소하기', kCancelButtonColor, _onCancelPressed),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    _buildPageView(),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/moli.gif', // 예시 이미지
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentScreen = ScreenState.values[index];
        });
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StartScreen(),
        PhoneAuthScreen(),
        PersonalInfoConsentScreen(
          onAllConsentsChecked: _onAllConsentsChecked, // 콜백 전달
        ),
        PersonalInformationInputScreen(
          onAuthenticationSuccess: _onAuthenticationStart,
        )
      ],
    );
  }

  void _onAllConsentsChecked(bool allChecked) {
    setState(() {
      _allConsentsChecked = allChecked; // 모든 항목 체크 상태 업데이트
    });
  }

  void _onAuthenticationStart() {
    setState(() {
      _isAuthenticated = true;
    });
  }

  Widget _buildNextButton() {
    return Visibility(
      visible: _canProceed(),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: _buildActionButton(context, '다음', kNextButtonColor, _onNextPressed),
    );
  }

  Future<void> _onNextPressed() async {

    if (_currentScreen.index == ScreenState.values.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SaveYourPassword()),
      );
    } else {
      int nextIndex = (_currentScreen.index + 1) % ScreenState.values.length;
      setState(() {
        _currentScreen = ScreenState.values[nextIndex];
      });
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onCancelPressed() {
    Navigator.pop(context);
  }

  bool _canProceed() {
    switch (_currentScreen) {
      case ScreenState.personalInfoConsent:
        return _allConsentsChecked; // 모든 항목이 체크된 경우에만 "다음" 버튼이 활성화
      case ScreenState.personalInfoInput:
        return _isAuthenticated; // 인증이 완료된 경우에만 "다음" 버튼이 보임
      default:
        return true;
    }
  }

  Widget _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
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
}
