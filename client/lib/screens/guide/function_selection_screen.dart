import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/account_info_input_screen.dart';
import 'package:ssyrial/screens/guide/stt_screen.dart';
import 'package:ssyrial/widgets/custom_dialog.dart';

class FunctionSelectionScreen extends StatelessWidget {
  final String title; // 화면 제목
  final String subtitle; // 설명 텍스트
  final TextStyle? titleTextStyle; // 제목 텍스트 스타일
  final TextStyle? subtitleTextStyle; // 설명 텍스트 스타일
  final List<String> buttonLabels; // 버튼 텍스트 목록
  final TextStyle? buttonTextStyle; // 버튼 텍스트 스타일
  final Color buttonColor; // 버튼 배경색
  final Color otherButtonColor; // "다른 기능 찾기" 버튼 배경색
  final String otherButtonText; // "다른 기능 찾기" 버튼 텍스트
  final EdgeInsetsGeometry padding; // 전체 화면 패딩
  final IconData micIcon; // 마이크 아이콘

  const FunctionSelectionScreen({
    Key? key,
    this.title = 'SSYRIAL_MAIN',
    this.subtitle = '도움이 필요한 기능을 선택해 주세요',
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.buttonLabels = const ['돈 넣기', '돈 찾기', '돈 보내기', '통장 조회'],
    this.buttonTextStyle,
    this.buttonColor = Colors.green, // 기본 버튼 배경색
    this.otherButtonColor = Colors.orange, // "다른 기능 찾기" 버튼 색상
    this.otherButtonText = '다른 기능 찾기', // "다른 기능 찾기" 기본 텍스트
    this.padding = const EdgeInsets.all(16.0), // 기본 패딩
    this.micIcon = Icons.mic, // 기본 마이크 아이콘
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: titleTextStyle), // 화면 제목
      ),
      body: Padding(
        padding: padding, // 전체 화면 패딩 설정
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(subtitle, style: subtitleTextStyle), // 설명 텍스트
            SizedBox(height: 20),
            _buildFunctionButtons(context), // 기능 버튼 위젯
            SizedBox(height: 20),
            _buildOtherFunctionButton(context), // "다른 기능 찾기" 버튼
            Spacer(),
            _buildMicInstructionAndIcon(context), // 마이크 사용 설명 및 아이콘
          ],
        ),
      ),
    );
  }
}

extension Widgets on FunctionSelectionScreen {
  // 기능 버튼을 그리드 형태로 배치하는 위젯
  Widget _buildFunctionButtons(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      shrinkWrap: true,
      itemCount: buttonLabels.length,
      itemBuilder: (context, index) {
        return _buildFunctionButton(context, buttonLabels[index]);
      },
    );
  }

  // 개별 기능 버튼 생성 함수
  Widget _buildFunctionButton(BuildContext context, String label) {
    return ElevatedButton(
      onPressed: () => _onFunctionButtonPressed(label, context),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // 버튼 배경색 설정
      ),
      child: Text(label, style: buttonTextStyle), // 버튼 텍스트 및 스타일 설정
    );
  }

  // "다른 기능 찾기" 버튼 위젯
  Widget _buildOtherFunctionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // "다른 기능 찾기" 버튼 클릭 시 동작
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: otherButtonColor, // "다른 기능 찾기" 버튼 배경색 설정
      ),
      child: Text(otherButtonText, style: buttonTextStyle), // 버튼 텍스트 및 스타일 설정
    );
  }

  // 마이크 사용 설명 텍스트 및 아이콘 위젯
  Widget _buildMicInstructionAndIcon(BuildContext context) {
    return Column(
      children: [
        Text('또는 버튼을 누르고 말해보세요'), // 설명 텍스트
        IconButton(
          icon: Icon(micIcon), // 마이크 아이콘 설정
          onPressed: () => _showSTTDialog(context), // 마이크 아이콘 클릭 시 STT 다이얼로그 호출
        ),
      ],
    );
  }
}

extension Functions on FunctionSelectionScreen {
  // 기능 버튼이 눌렸을 때 동작
  void _onFunctionButtonPressed(String label, BuildContext context) {
    if (label == '돈 보내기') {
      // "돈 보내기" 버튼 클릭 시 AccountInfoInputScreen으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountInfoInputScreen()),
      );
    } else {
      // 다른 기능에 대한 처리
      // 추가 기능을 구현하거나 다른 화면으로의 이동을 여기에 처리할 수 있습니다.
    }
  }

  // STT 다이얼로그 표시 함수
  void _showSTTDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(child: STTScreen()), // STT 화면을 포함한 다이얼로그 호출
    );
  }
}
