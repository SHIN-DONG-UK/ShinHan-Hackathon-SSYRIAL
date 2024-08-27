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
