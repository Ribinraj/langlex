import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const RegisterButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 13),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: const Color(0xFF667EEA).withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add, size: 24),
          SizedBox(width: 12),
          Text(
            'Register New Student',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
