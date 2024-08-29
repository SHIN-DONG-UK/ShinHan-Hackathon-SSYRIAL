import 'package:flutter/material.dart';
import 'package:ssyrial/sooyeon_front/register/personal_info_consent_screen.dart';
import 'package:ssyrial/sooyeon_front/register/phone_auth_screen.dart';
import 'package:ssyrial/sooyeon_front/register/start_screen.dart';
import '../1-2.cancle_member_registration.dart';
import 'authentication_screen.dart';
import 'constants.dart';
import 'personal_information_input_screen.dart';
import '../9.save_your_password.dart'; // SaveYourPassword 화면 임포트
import 'package:ssyrial/config/tts_config.dart'; // Import TTSConfig

enum ScreenState {
  start,
  phoneAuth,
  personalInfoConsent,
  personalInfoInput,
  authenticationStart,
  completionScreen, // Completion screen for after authentication
}

class MemberRegistrationStartScreen extends StatefulWidget {
  const MemberRegistrationStartScreen({super.key});

  @override
  _MemberRegistrationStartScreenState createState() =>
      _MemberRegistrationStartScreenState();
}

class _MemberRegistrationStartScreenState
    extends State<MemberRegistrationStartScreen> {
  ScreenState _currentScreen = ScreenState.start;
  List<bool> _isChecked = [false, false, false, false, false];
  final PageController _pageController = PageController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  String? _selectedGender;
  bool _isAuthenticated = false;
  final TTSConfig ttsConfig = TTSConfig(); // TTSConfig instance

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
              _buildActionButton(
                  context, '취소하기', kCancelButtonColor, _onCancelPressed),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentScreen = ScreenState.values[index];
                    });
                  },
                  children: [
                    StartScreen(
                      onTTSComplete: _onNextPressed, // Navigate when TTS completes
                    ),
                    PhoneAuthScreen(),
                    PersonalInfoConsentScreen(
                      isChecked: _isChecked,
                      onCheckedChanged: _updateConsentState,
                    ),
                    PersonalInformationInputScreen(
                      nameController: _nameController,
                      birthdayController: _birthdayController,
                      selectedGender: _selectedGender,
                      onNameChanged: (value) => setState(() {}),
                      onBirthdayChanged: (value) => setState(() {}),
                      onGenderSelected: (gender) => setState(() {
                        _selectedGender = gender;
                      }),
                    ),
                    AuthenticationScreen(
                      onAuthenticationComplete: () => setState(() {
                        _onAuthenticationStart();
                      }),
                    ), // AuthenticationStartScreen 추가
                  ],
                ),
              ),
              if (_canProceed())
                _buildActionButton(
                    context, '다음', kNextButtonColor, _onNextPressed),
            ],
          ),
        ),
      ),
    );
  }

  void _updateConsentState(List<bool> newCheckedValues) {
    setState(() {
      _isChecked = newCheckedValues;
    });
  }

  Future<void> _onNextPressed() async {
    await ttsConfig.stop(); // Stop any ongoing TTS

    if (_currentScreen.index == ScreenState.values.length - 1) {
      // 마지막 페이지면 새로운 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveYourPassword(), // SaveYourPassword 화면으로 이동
        ),
      );
    } else {
      // 다음 페이지로 이동
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

  void _onAuthenticationStart() {
    // Here you simulate the authentication process completion
    setState(() {
      _isAuthenticated = true;
      _currentScreen = ScreenState.completionScreen;
    });
  }

  void _onCancelPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CancelMemberRegistrationScreen(),
      ),
    );
  }

  bool _canProceed() {
    if (_currentScreen == ScreenState.personalInfoConsent) {
      return _isChecked[0];
    }
    if (_currentScreen == ScreenState.personalInfoInput) {
      return _selectedGender != null;
    }
    if (_currentScreen == ScreenState.completionScreen) {
      return _isAuthenticated; // 활성화된 인증 상태에서만 다음 버튼이 나타남
    }
    return _currentScreen != ScreenState.authenticationStart;
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
