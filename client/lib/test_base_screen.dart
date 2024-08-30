import 'package:flutter/material.dart';
import 'package:ssyrial/test_container.dart';
import 'package:ssyrial/screens/register/phone_auth_screen.dart';
import 'config/constants.dart';
import 'screens/register/9.save_your_password.dart';
import 'package:ssyrial/config/tts_config.dart';

enum ScreenState {
  test1
  //TODO:여기에 만든 스크린 이름을 대충 넣으면됩니다
}

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ScreenState _currentScreen = ScreenState.test1;
  final PageController _pageController = PageController();
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
              _buildActionButton(context, '취소하기', kCancelButtonColor, _onCancelPressed),
              const SizedBox(height: 20),
              Expanded(child: _buildPageView()),
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
      children: [
        test1()
        //TODO:여기에 만든 스크린을 넣으면됩니다
      ],
    );
  }

  Widget _buildNextButton() {
    return Visibility(
      visible: true,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: _buildActionButton(context, '다음', kNextButtonColor, _onNextPressed),
    );
  }


  Future<void> _onNextPressed() async {
    await _ttsConfig.stop();

    if (_currentScreen.index == ScreenState.values.length - 1) {

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

  Widget _buildActionButton(BuildContext context, String label, Color color, VoidCallback onPressed) {
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