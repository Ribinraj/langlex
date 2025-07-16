import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class CustomSqureElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundcolor;
  final double height;
  const CustomSqureElevatedButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.backgroundcolor,
      this.height = 67});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
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
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
