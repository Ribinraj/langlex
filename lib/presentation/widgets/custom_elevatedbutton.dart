import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color backgroundcolor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,  this.backgroundcolor=Appcolors.korangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadiusStyles.kradius30(),
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
