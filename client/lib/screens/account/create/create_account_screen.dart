import 'package:flutter/material.dart';
import 'package:ssyrial/config/constants.dart'; // Assuming constants are defined here

enum ScreenState {
  homeScreen, // Added new screen state for HomeScreen
  // Add more screen states as needed
}

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  ScreenState _currentScreen = ScreenState.homeScreen; // Default screen
  final PageController _pageController = PageController();

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
              _buildActionButton(context, '돌아가기', kCancelButtonColor, _onCancelPressed),
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
        CreateAccountHome(), // Updated with HomeScreen
        // Add more screens here as needed
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

    if (_currentScreen.index == ScreenState.values.length - 1) {
      // Last screen logic here
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

class CreateAccountHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //_buildHeader(),
              SizedBox(height: 20),
              _buildInstructions(),
              SizedBox(height: 20),
              _buildButton('입출금', Icons.swap_vert),
              SizedBox(height: 10),
              _buildButton('예금', Icons.arrow_upward),
              SizedBox(height: 10),
              _buildButton('적금', Icons.arrow_upward),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '돌아가기',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '생성할 계좌의',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '종류를 선택해주세요.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          '버튼을 길게 눌러',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Text(
          '설명을 확인하세요.',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildButton(String text, IconData icon) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Row(
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 18)),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Add button action here
        },
      ),
    );
  }
}
