import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_keypad_password_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_success_dialog.dart';

class ConfirmationPopup extends StatelessWidget {
  final String titleText = '이 금액이 맞나요?';
  final String Password = '123';
  String enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 텍스트 위젯1
          Text(
            titleText,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          // 박스1
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // row1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('금', style: TextStyle(fontSize: 18)),
                    Text('100,000원', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 10),
                // row2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('금', style: TextStyle(fontSize: 18)),
                    Text('십만원', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                  _showPasswordPad(context); // 비밀번호 숫자패드 팝업 열기
                },
                child: Text('네'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 현재 팝업 닫기
                },
                child: Text('아니오'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 비밀번호 숫자패드 팝업을 여는 함수
  void _showPasswordPad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HowMuchKeypadPasswordDialog();
      },
    );
  }

  void _showSuccessDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return TransferSuccessPopup();
        });
  }

  // 오류 다이얼로그를 보여주는 함수
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('비밀번호가 틀립니다. 다시 시도해주세요.', style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 오류 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

class AccountConfirmationDialog extends StatelessWidget {
  final String accountNumber;
  final String selectedBank;
  final String correctTitle;
  final String incorrectTitle;
  final String confirmName;

  AccountConfirmationDialog({
    required this.accountNumber,
    required this.selectedBank,
    this.correctTitle = "이 통장이 맞나요?",
    this.incorrectTitle = "통장 정보를 다시 확인해 주세요.",
    this.confirmName = "김신한",
  });

  @override
  Widget build(BuildContext context) {
    return accountNumber == "123"
        ? _buildCorrectAccountDialog(context)
        : _buildIncorrectAccountDialog(context);
  }

  Widget _buildCorrectAccountDialog(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // 다이얼로그를 화면 상단에 고정
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width, // 화면의 너비를 가득 채움
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                correctTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                confirmName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                selectedBank,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                accountNumber,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    // [API] 현재 계좌의 통장 잔고를 확인하는 API 땡겨오기
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true), // true를 반환하고 팝됨
                      child: Text("네", style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("아니오", style: TextStyle(color: Colors.black, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncorrectAccountDialog(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // 다이얼로그를 화면 상단에 고정
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width, // 화면의 너비를 가득 채움
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                incorrectTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                selectedBank,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                accountNumber,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => {Navigator.of(context).pop()},
                child: Text("돌아가기", style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

void showTopAccountConfirmationDialog(BuildContext context, String accountNumber, String selectedBank) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return SafeArea(
        child: AccountConfirmationDialog(
          accountNumber: accountNumber,
          selectedBank: selectedBank,
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1), // 화면 위에서 아래로 슬라이드
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 300), // 애니메이션 지속 시간
  );
}