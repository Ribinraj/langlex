import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double Function(BuildContext) fontSize; // Function to calculate font size

  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize(context), // Use the function to get font size
      ),
    );
  }
}
