import 'package:flutter/material.dart';

class SendMoneyRejectPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the entire screen
      body: Center(
        child: Container(
          width: 300,  // Width of the red container
          padding: EdgeInsets.all(16),  // Padding inside the red container
          decoration: BoxDecoration(
            color: Colors.red,  // Red color for the container
            borderRadius: BorderRadius.circular(16),  // Rounded corners for the container
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Makes the column take up the minimum space it needs
            mainAxisAlignment: MainAxisAlignment.center,  // Centers its children vertically
            crossAxisAlignment: CrossAxisAlignment.center,  // Centers its children horizontally
            children: [
              // "X" image
              Image.asset(
                'assets/x_image.png',  // Path to the "X" image
                width: 50,  // Width of the image
                height: 50,  // Height of the image
              ),
              SizedBox(height: 16),  // Space between the image and the text
              // Text indicating password rejection
              Text(
                '비밀번호가 틀렸어요',  // Korean text for "The password is incorrect"
                style: TextStyle(
                  color: Colors.white,  // White color for the text
                  fontSize: 18,  // Font size of the text
                  fontWeight: FontWeight.bold,  // Bold text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
