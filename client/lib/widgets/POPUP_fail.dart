import 'package:flutter/material.dart';

class PasswordFailPopup extends StatefulWidget {
  final VoidCallback onRetry;
  final VoidCallback onCancel;
  final String message; // The message to display in the popup

  const PasswordFailPopup({
    Key? key,
    required this.onRetry,
    required this.onCancel,
    required this.message, // Required parameter for message
  }) : super(key: key);

  @override
  _PasswordFailPopupState createState() => _PasswordFailPopupState();
}

class _PasswordFailPopupState extends State<PasswordFailPopup>
    with SingleTickerProviderStateMixin {
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
    return ScaleTransition(
      scale: _animation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.message, // Displaying the custom message
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: widget.onRetry,
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
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the popup
void showPasswordFailPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return PasswordFailPopup(
        onRetry: () {
          Navigator.of(context).pop();
          // Add logic for retrying, e.g., re-prompting for password
        },
        onCancel: () {
          Navigator.of(context).pop();
          // Add logic for canceling, e.g., returning to the previous screen
        },
        message: message, // Pass the custom message
      );
    },
  );
}
