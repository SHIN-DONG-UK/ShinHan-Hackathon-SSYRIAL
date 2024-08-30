import 'package:flutter/material.dart';
import 'package:ssyrial/screens/register/personal_info_consent_screen.dart';
import 'package:ssyrial/screens/register/phone_auth_screen.dart';
import 'package:ssyrial/screens/register/start_screen.dart';
import 'authentication_screen.dart';
import '../../config/constants.dart';
import 'personal_information_input_screen.dart';
import '9.save_your_password.dart';
import 'package:ssyrial/config/tts_config.dart';

enum ScreenState {
  start,
  phoneAuth,
  personalInfoConsent,
  personalInfoInput,
  authenticationStart,
  completionScreen,
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
  final List<bool> _isChecked = List.filled(5, false);
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? _selectedGender;
  bool _isAuthenticated = false;
  final TTSConfig _ttsConfig = TTSConfig();

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
      physics: const NeverScrollableScrollPhysics(), // 스와이프를 비활성화합니다.
      children: [
        StartScreen(onTTSComplete: _onStartScreenTTSComplete),
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
        ),
      ],
    );
  }


  Widget _buildNextButton() {
    return Visibility(
      visible: _canProceed(),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child:
          _buildActionButton(context, '다음', kNextButtonColor, _onNextPressed),
    );
  }

  void _updateConsentState(List<bool> newCheckedValues) {
    setState(() {
      for (int i = 0; i < _isChecked.length; i++) {
        _isChecked[i] = newCheckedValues[i];
      }
    });
  }

  Future<void> _onStartScreenTTSComplete() async {
    if (_currentScreen == ScreenState.start) {
      await _onNextPressed();
    }
  }

  Future<void> _onNextPressed() async {
    await _ttsConfig.stop();

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

  void _onAuthenticationStart() {
    setState(() {
      _isAuthenticated = true;
      _currentScreen = ScreenState.completionScreen;
    });
  }

  void _onCancelPressed() {
    Navigator.pop(context);
  }

  bool _canProceed() {
    switch (_currentScreen) {
      case ScreenState.personalInfoConsent:
        return _isChecked[0];
      case ScreenState.personalInfoInput:
        return _selectedGender != null;
      case ScreenState.completionScreen:
        return _isAuthenticated;
      case ScreenState.authenticationStart:
        return false;
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
