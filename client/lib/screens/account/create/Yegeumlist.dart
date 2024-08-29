import 'package:flutter/material.dart';

class Yegeumlist extends StatelessWidget {
  const Yegeumlist({super.key});

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/CreateAccount_select_yegeum_from_category.png',
              fit: BoxFit.fitHeight,
            ),
          ),

          //돌아가기 버튼
          Positioned(
            top: screenwidth * 0.02,
            child: SizedBox(
              width: screenwidth,
              height: screenheight * 0.15,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                ),
                child: Text(''), // Empty text as the image itself has text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
