import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

class CustomLanguageContainer extends StatelessWidget {
  const CustomLanguageContainer({
    super.key,
    required this.languageText,
    required this.heroTag,
  });

  final String languageText;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: ResponsiveUtils.hp(6.5),
        decoration: BoxDecoration(
            //color: Colors.transparent,
            gradient: LinearGradient(
              colors: [
                Appcolors.kgreenColor,
                const Color.fromARGB(255, 196, 164, 228)
              ], // Replace with your preferred colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: .5, color: const Color.fromARGB(255, 120, 179, 162))),
        child: Center(
          child: TextStyles.body(
            text: languageText,
            color: Appcolors.kwhiteColor,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
