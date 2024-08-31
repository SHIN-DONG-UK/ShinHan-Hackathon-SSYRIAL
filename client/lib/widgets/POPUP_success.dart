import 'package:flutter/material.dart';
import 'dart:async';

class SuccessPopup extends StatefulWidget {
  final String message; // 팝업에 표시할 메시지
  final VoidCallback onComplete;

  const SuccessPopup({
    Key? key,
    required this.message, // 메시지 파라미터 추가
    required this.onComplete,
  }) : super(key: key);

  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.8; // 전체 화면의 80% 크기

    return ScaleTransition(
      scale: _animation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: dialogWidth,
          padding: const EdgeInsets.all(24), // 더 큰 padding
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24), // 상단 여백 추가
              Container(
                padding: const EdgeInsets.all(24), // 내부 padding도 키움
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80, // 더 큰 아이콘
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 50, // 아이콘 크기 키움
                      ),
                    ),
                    const SizedBox(height: 24), // 아이콘과 텍스트 사이 여백 증가
                    Text(
                      widget.message, // 사용자 정의 메시지
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18, // 폰트 크기 키움
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // 아래 여백도 키움
              ElevatedButton(
                onPressed: widget.onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 팝업을 표시하는 함수
void showSuccessPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false, // 팝업 외부를 클릭해도 닫히지 않도록 설정
    builder: (BuildContext context) {
      return SuccessPopup(
        message: message, // 팝업에 표시할 메시지를 전달
        onComplete: () {
          Navigator.of(context).pop();
          // 추가 동작을 위한 로직을 여기에 추가 가능
        },
      );
    },
  );
}
