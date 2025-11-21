import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class CustomSqureElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color backgroundcolor;
  final double height;
  final bool isLoading;

  const CustomSqureElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundcolor,
    this.height = 67,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;
    final buttonColor = isDisabled
        ? backgroundcolor.withOpacity(0.5)
        : backgroundcolor;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            backgroundColor: buttonColor,
            disabledBackgroundColor: buttonColor,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Appcolors.kwhiteColor,
                    ),
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  buttonText,
                  style: const TextStyle(
                    color: Appcolors.kwhiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}