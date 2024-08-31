import 'package:flutter/material.dart';

// 계좌 번호 입력 다이얼로그를 나타내는 StatefulWidget 클래스
class AccountNumberInputDialog extends StatefulWidget {
  final Function(String) onAccountNumberEntered; // 입력된 계좌번호를 전달할 콜백 함수
  final String title; // 다이얼로그의 제목
  final TextStyle? titleTextStyle; // 제목의 텍스트 스타일 (옵션)
  final TextStyle? accountNumberTextStyle; // 입력된 계좌 번호 텍스트 스타일 (옵션)
  final TextStyle? buttonTextStyle; // 버튼의 텍스트 스타일 (옵션)

  AccountNumberInputDialog({
    required this.onAccountNumberEntered,
    this.title = "계좌번호를 입력하세요",
    this.titleTextStyle,
    this.accountNumberTextStyle,
    this.buttonTextStyle,
  });

  @override
  _AccountNumberInputDialogState createState() => _AccountNumberInputDialogState();
}

class _AccountNumberInputDialogState extends State<AccountNumberInputDialog> {
  String _enteredAccountNumber = ""; // 입력된 계좌 번호를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // 다이얼로그를 화면 상단에 고정
      child: Material(
        color: Colors.transparent, // 다이얼로그의 배경을 투명하게 설정
        child: Container(
          width: MediaQuery.of(context).size.width, // 화면 가로를 가득 채움
          padding: EdgeInsets.all(16), // 컨테이너의 내부 여백 설정
          decoration: BoxDecoration(
            color: Colors.white, // 다이얼로그의 배경색을 흰색으로 설정
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 다이얼로그의 높이를 내용에 맞게 조정
            children: [
              // 다이얼로그의 제목 표시
              Text(
                widget.title,
                style: widget.titleTextStyle ?? TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16), // 제목과 입력된 계좌 번호 사이의 간격

              // 입력된 계좌 번호를 보여주는 컨테이너
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // 회색 테두리 설정
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _enteredAccountNumber, // 입력된 계좌 번호를 표시
                  style: widget.accountNumberTextStyle ?? TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16), // 계좌 번호와 키패드 사이의 간격

              // 숫자 키패드 생성
              _buildNumericKeypad(),
              SizedBox(height: 16), // 키패드와 버튼들 사이의 간격

              // 취소 및 입력 버튼
              Row(
                children: [
                  // 취소 버튼
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                      child: Text("취소", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // 버튼 배경색 빨간색
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // 두 버튼 사이의 간격

                  // 입력 버튼
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAccountNumberEntered(_enteredAccountNumber); // 입력된 계좌 번호를 콜백 함수로 전달
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text("입력", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 버튼 배경색 파란색
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

  // 숫자 키패드를 생성하는 함수
  Widget _buildNumericKeypad() {
    return GridView.count(
      crossAxisCount: 3, // 3개의 열로 구성된 그리드
      shrinkWrap: true, // 그리드뷰의 높이를 내용에 맞게 조정
      childAspectRatio: 1.5, // 버튼의 가로 세로 비율 설정
      mainAxisSpacing: 8, // 버튼들 사이의 세로 간격
      crossAxisSpacing: 8, // 버튼들 사이의 가로 간격
      children: List.generate(12, (index) {
        if (index == 9) {
          // 전체삭제 버튼
          return _buildKeypadButton(
            text: "전체삭제",
            onPressed: () => setState(() => _enteredAccountNumber = ""), // 입력된 계좌번호 초기화
            color: Colors.red,
          );
        } else if (index == 10) {
          // 0 버튼
          return _buildKeypadButton(
            text: "0",
            onPressed: () => setState(() => _enteredAccountNumber += "0"),
            color: Colors.green, // 초록색 배경
          );
        } else if (index == 11) {
          // 하나삭제 버튼
          return _buildKeypadButton(
            text: "하나삭제",
            color: Colors.red,
            onPressed: () {
              // 마지막 입력된 문자 삭제
              if (_enteredAccountNumber.isNotEmpty) {
                setState(() => _enteredAccountNumber = _enteredAccountNumber.substring(0, _enteredAccountNumber.length - 1));
              }
            },
          );
        } else {
          // 1~9 숫자 버튼
          return _buildKeypadButton(
            text: (index + 1).toString(),
            onPressed: () => setState(() => _enteredAccountNumber += (index + 1).toString()),
            color: Colors.green, // 초록색 배경
          );
        }
      }),
    );
  }

  // 키패드 버튼을 생성하는 함수
  Widget _buildKeypadButton({required String text, required VoidCallback onPressed, Color color = Colors.green}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 30, color: Colors.white)), // 버튼 텍스트 스타일
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // 버튼 배경색
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 버튼 모서리 둥글게 설정
        elevation: 0, // 버튼 그림자 없음
      ),
    );
  }
}

// 다이얼로그를 화면 상단에 고정하여 표시하는 함수
void showTopAccountNumberInputDialog(BuildContext context, Function(String) onAccountNumberEntered) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // 사용자가 다이얼로그 밖을 클릭하면 닫힐 수 있도록 설정
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54, // 배경을 반투명한 검은색으로 설정
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return SafeArea(
        child: AccountNumberInputDialog(
          onAccountNumberEntered: onAccountNumberEntered, // 입력된 계좌 번호를 전달받는 콜백 함수
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1), // 화면 위에서 아래로 슬라이드
          end: Offset.zero, // 최종 위치는 화면의 제자리
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 300), // 다이얼로그 슬라이드 애니메이션의 지속 시간 설정
  );
}
