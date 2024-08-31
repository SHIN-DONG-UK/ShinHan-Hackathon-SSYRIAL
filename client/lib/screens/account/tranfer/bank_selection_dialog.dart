import 'package:flutter/material.dart';

/// 은행 선택 다이얼로그 위젯
class BankSelectionDialog extends StatelessWidget {
  final Function(String) onBankSelected; // 은행 선택 시 호출되는 콜백 함수
  final String title; // 다이얼로그 제목
  final TextStyle? titleTextStyle; // 다이얼로그 제목 스타일
  final TextStyle? bankTextStyle; // 은행 버튼 텍스트 스타일
  final TextStyle? cancelButtonTextStyle; // 취소 버튼 텍스트 스타일

  BankSelectionDialog({
    required this.onBankSelected,
    this.title = "은행을 선택하세요",
    this.titleTextStyle,
    this.bankTextStyle = const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
    this.cancelButtonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 크기 계산을 위해 MediaQuery 사용
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.topCenter, // 다이얼로그를 화면 상단에 배치
      child: Material(
        color: Colors.transparent, // 배경색 투명
        child: Container(
          width: screenWidth, // 화면 너비만큼 사용
          height: screenHeight * 2 / 3, // 화면 높이의 2/3 사용
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDialogTitle(), // 다이얼로그 제목 빌드
              SizedBox(height: 16),
              _buildBankGrid(context), // 은행 선택 그리드 빌드
              SizedBox(height: 16),
              _buildCancelButton(context), // 취소 버튼 빌드
            ],
          ),
        ),
      ),
    );
  }

  /// 다이얼로그 제목 빌드 함수
  Widget _buildDialogTitle() {
    return Text(
      title,
      style: titleTextStyle ??
          TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  /// 은행 선택 버튼 그리드를 빌드하는 함수
  Widget _buildBankGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3, // 3개의 열로 그리드 구성
        mainAxisSpacing: 8, // 그리드 아이템 간 세로 간격
        crossAxisSpacing: 8, // 그리드 아이템 간 가로 간격
        children: _buildBankButtons(context), // 은행 선택 버튼들 생성
      ),
    );
  }

  /// 은행 선택 버튼들 리스트를 생성하는 함수
  List<Widget> _buildBankButtons(BuildContext context) {
    List<String> banks = [
      "신한", "농협", "하나", "기업", "국민", "우리",
      "새마을", "부산", "대구", "우체국", "신협", "저축"
    ];

    // 각 은행 버튼을 빌드하여 리스트로 반환
    return banks.map((bank) {
      return ElevatedButton(
        onPressed: () {
          onBankSelected(bank); // 은행 선택 시 콜백 함수 호출
          Navigator.of(context).pop(); // 다이얼로그 닫기
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 둥근 모서리
          ),
        ),
        child: Text(
          bank,
          style: bankTextStyle ?? TextStyle(color: Colors.black), // 버튼 텍스트 스타일
        ),
      );
    }).toList();
  }

  /// 취소 버튼 빌드 함수
  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 버튼 너비를 가득 채움
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(), // 취소 버튼 클릭 시 다이얼로그 닫기
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 둥근 모서리
          ),
          padding: EdgeInsets.symmetric(vertical: 12), // 버튼 패딩
        ),
        child: Text(
          "취소", // 취소 버튼 텍스트
          style: cancelButtonTextStyle ?? TextStyle(color: Colors.white), // 텍스트 스타일
        ),
      ),
    );
  }
}

/// 상단에 나타나는 은행 선택 다이얼로그를 표시하는 함수
void showTopBankSelectionDialog(BuildContext context, Function(String) onBankSelected) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // 다이얼로그 외부 클릭 시 닫기 가능 여부
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel, // 접근성 라벨
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return SafeArea(
        child: BankSelectionDialog(
          onBankSelected: onBankSelected,
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1), // 화면 위에서 아래로 슬라이드
          end: Offset.zero, // 최종 위치
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 300), // 애니메이션 지속 시간
  );
}
