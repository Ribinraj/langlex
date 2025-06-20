import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class CustomSqureElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundcolor;

  const CustomSqureElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundcolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            backgroundColor: backgroundcolor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Appcolors.kwhiteColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
