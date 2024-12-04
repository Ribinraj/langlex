import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

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
        height: h(context) * .07,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.2, color: Appcolors.kgreenColor)),
        child: Center(
          child: Text(
            languageText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppDimensions.fontSize20(context),
              color: Appcolors.korangeColor,
            ),
          ),
        ),
      ),
    );
  }
}
