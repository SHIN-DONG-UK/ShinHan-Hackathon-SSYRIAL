import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/account_confirmation_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/account_number_input_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/bank_selection_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_reject_password_dialog.dart';

class AccountInfoInputScreen extends StatefulWidget {
  final String initialTitle; // 초기 화면의 제목
  final String newTitle; // 계좌 정보 입력 화면의 제목
  final String backButtonText; // 돌아가기 버튼의 텍스트
  final String bankButtonText; // 은행 선택 버튼의 기본 텍스트
  final String accountNumberLabel; // 계좌 번호 라벨 텍스트
  final String submitButtonText; // 보내기 버튼의 텍스트
  final TextStyle? titleTextStyle; // 제목 텍스트 스타일
  final TextStyle? labelTextStyle; // 라벨 텍스트 스타일
  final TextStyle? buttonTextStyle; // 버튼 텍스트 스타일
  final Color buttonColor; // 버튼 배경 색상
  final EdgeInsetsGeometry padding; // 전체 화면의 패딩

  const AccountInfoInputScreen({
    Key? key,
    this.initialTitle = '안녕하세요\n송금하는 법을 알려드릴게요\n(음성 끝나면 자동으로 다음페이지)',
    this.newTitle = '돈을 받는 통장의 정보를 입력해 주세요.',
    this.backButtonText = '돌아가기',
    this.bankButtonText = '은행 선택하기',
    this.accountNumberLabel = '계좌 번호',
    this.submitButtonText = '보내기',
    this.titleTextStyle,
    this.labelTextStyle,
    this.buttonTextStyle,
    this.buttonColor = Colors.blue,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  _AccountInfoInputScreenState createState() => _AccountInfoInputScreenState();
}

class _AccountInfoInputScreenState extends State<AccountInfoInputScreen> {
  bool _isInitialScreen = true; // 초기 화면인지 여부를 나타내는 플래그
  String _selectedBank = ""; // 선택된 은행 이름
  bool _bankSelected = false; // 은행이 선택되었는지 여부를 나타내는 플래그
  String _accountNumber = ""; // 사용자가 입력한 계좌번호
  bool _accountNumberEntered = false; // 계좌번호가 입력되었는지 여부를 나타내는 플래그

  @override
  void initState() {
    super.initState();
    // 2초 후에 초기 화면에서 계좌 정보 입력 화면으로 전환
    // TODO: 음성 재생이 종료되면 넘어가기
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isInitialScreen = false; // 화면 전환 플래그를 업데이트
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: widget.padding, // 전체 화면 패딩 적용
        child: Stack(
          children: [
            // 돌아가기 버튼 (화면 상단 좌측)
            Positioned(
              top: 40,
              left: 20,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // 이전 화면으로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // 돌아가기 버튼의 배경색
                ),
                icon: Icon(Icons.arrow_back), // 돌아가기 화살표 아이콘
                label: Text(widget.backButtonText), // 돌아가기 버튼 텍스트
              ),
            ),
            // 화면의 중심 컨텐츠
            Center(
              child: _isInitialScreen ? _buildInitialContent() : _buildNewContent(),
            ),
          ],
        ),
      ),
    );
  }

  // 초기 화면의 내용을 구성하는 위젯
  Widget _buildInitialContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.initialTitle, // 초기 화면의 텍스트
          textAlign: TextAlign.center,
          style: widget.titleTextStyle, // 텍스트 스타일
        ),
        SizedBox(height: 20),
        Image.asset(
          'assets/images/moli.gif', // 이미지 경로 (자신의 경로로 대체 필요)
          width: 150,
          height: 150,
        ),
      ],
    );
  }

  // 계좌 정보 입력 화면의 내용을 구성하는 위젯
  Widget _buildNewContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.newTitle, // 계좌 정보 입력 화면의 텍스트
          textAlign: TextAlign.center,
          style: widget.titleTextStyle, // 텍스트 스타일
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _showBankSelectionDialog, // 은행 선택 다이얼로그 표시
          child: Text(_selectedBank.isEmpty ? widget.bankButtonText : _selectedBank), // 선택된 은행 또는 기본 텍스트 표시
        ),
        SizedBox(height: 20),
        // 계좌 번호 입력 버튼
        if (_bankSelected) ...[
          Text(widget.accountNumberLabel, style: widget.labelTextStyle),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _showCustomAccountNumberDialog, // 계좌 번호 입력 다이얼로그 표시
            child: Text(_accountNumber.isEmpty ? '계좌번호 입력' : _accountNumber), // 선택된 계좌 또는 기본 텍스트 표시
          ),
        ],
        // 보내기 버튼
        if (_accountNumberEntered) ...[
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showConfirmationDialog, // 보내기 버튼 클릭 시 확인 다이얼로그 표시
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.buttonColor, // 보내기 버튼의 배경색
            ),
            child: Text(
              widget.submitButtonText, // 보내기 버튼 텍스트
              style: widget.buttonTextStyle, // 보내기 버튼 텍스트 스타일
            ),
          ),
        ]
      ],
    );
  }

  // 은행 선택 다이얼로그 표시 함수
  void _showBankSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BankSelectionDialog(
          onBankSelected: (selectedBank) {
            setState(() {
              _selectedBank = selectedBank; // 선택된 은행 업데이트
              _bankSelected = true; // 은행이 선택되었음을 나타내는 플래그 설정
            });
          },
        );
      },
    );
  }

  // 계좌 번호 입력 다이얼로그 표시 함수
  void _showCustomAccountNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AccountNumberInputDialog(
          onAccountNumberEntered: (enteredAccountNumber) {
            setState(() {
              _accountNumber = enteredAccountNumber; // 입력된 계좌 번호 저장
              _accountNumberEntered = true; // 계좌 번호가 입력되었음을 나타내는 플래그 설정
            });
          },
        );
      },
    );
  }

  // 확인 다이얼로그 표시 함수
  void _showConfirmationDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AccountConfirmationDialog(
          accountNumber: _accountNumber, // 입력된 계좌 번호 전달
          selectedBank: _selectedBank, // 선택된 은행 전달
        );
      },
    );
    if(result == true){
      Navigator.push(context, MaterialPageRoute(
          builder: (context){
        return HowMuchScreen();
      },
    ));}
  }
}
