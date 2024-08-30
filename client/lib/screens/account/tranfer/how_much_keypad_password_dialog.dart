import 'package:flutter/material.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_reject_password_dialog.dart';
import 'package:ssyrial/screens/account/tranfer/how_much_success_dialog.dart';

// 계좌 번호 입력 다이얼로그를 나타내는 StatefulWidget 클래스
class HowMuchKeypadPasswordDialog extends StatefulWidget {
  final String title; // 다이얼로그의 제목
  final TextStyle? titleTextStyle; // 제목의 텍스트 스타일 (옵션)
  final TextStyle? moneyTextStyle; // 입력된 금액 텍스트 스타일 (옵션)
  final TextStyle? buttonTextStyle; // 버튼의 텍스트 스타일 (옵션)
  final String password = '123'; // 임의로 정해둔 비밀번호

  HowMuchKeypadPasswordDialog({
    this.title = "비밀번호를\n입력하세요",
    this.titleTextStyle,
    this.moneyTextStyle,
    this.buttonTextStyle,
  });

  @override
  _HowMuchKeypadPasswordDialogState createState() => _HowMuchKeypadPasswordDialogState();
}

class _HowMuchKeypadPasswordDialogState extends State<HowMuchKeypadPasswordDialog> {
  String _enteredNumber = ""; // 입력된 계좌 번호를 저장하는 변수

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

              // 입력된 번호를 보여주는 컨테이너
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // 회색 테두리 설정
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _enteredNumber, // 입력된 금액을 표시
                  style: widget.moneyTextStyle ?? TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        // [DB] 사용자 비밀번호를 DB에서 가져와서 입력한 번호와 일치하는지 판단해야 함
                        if (_enteredNumber == widget.password) {
                          // Password matches, show success dialog
                          Navigator.pop(context);
                          _showSuccessDialog(context);
                        } else {
                          // Password does not match, show error dialog
                          _showErrorDialog(context);
                        }
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
            onPressed: () => setState(() => _enteredNumber = ""), // 입력된 계좌번호 초기화
            color: Colors.grey[300]!,
          );
        } else if (index == 10) {
          // 0 버튼
          return _buildKeypadButton(
            text: "0",
            onPressed: () => setState(() => _enteredNumber += "0"),
          );
        } else if (index == 11) {
          // 하나삭제 버튼
          return _buildKeypadButton(
            text: "하나삭제",
            onPressed: () {
              // 마지막 입력된 문자 삭제
              if (_enteredNumber.isNotEmpty) {
                setState(() => _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1));
              }
            },
            color: Colors.grey[300]!,
          );
        } else {
          // 1~9 숫자 버튼
          return _buildKeypadButton(
            text: (index + 1).toString(),
            onPressed: () => setState(() => _enteredNumber += (index + 1).toString()),
          );
        }
      }),
    );
  }

  // 키패드 버튼을 생성하는 함수
  Widget _buildKeypadButton({required String text, required VoidCallback onPressed, Color color = Colors.white}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 20, color: Colors.black)), // 버튼 텍스트 스타일
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // 버튼 배경색
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 버튼 모서리 둥글게 설정
        elevation: 0, // 버튼 그림자 없음
      ),
    );
  }

  // 성공 다이얼로그를 보여주는 함수
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TransferSuccessPopup();
      },
    );
  }

  // 오류 다이얼로그를 보여주는 함수
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SendMoneyRejectPassword();
      },
    );
  }
}
