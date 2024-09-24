import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class CustomLanguageContainer extends StatelessWidget {
  const CustomLanguageContainer({
    super.key,
    required this.languageText,
    required this.heroTag, // Add this parameter for a unique tag
  });

  final String languageText;
  final String heroTag; // Unique tag

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h(context) * .15,
      width: w(context) * 1,
      padding: const EdgeInsets.all(AppDimensions.paddingSize10),
      child: Stack(
        children: [
          Positioned(
            left: w(context) * .15,
            child: Container(
              width: w(context) * .75,
              height: h(context) * .1,
              decoration: BoxDecoration(
                color: Appcolors.kgreenColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kgreycolor.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: Opacity(
                opacity: 1,
                child: Center(
                  child: Text(
                    languageText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.fontSize25(context),
                      color: Appcolors.kwhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: h(context) * -.05,
            left: w(context) * .04,
            child: Hero(
              tag: heroTag, // Use the unique heroTag passed as parameter
              transitionOnUserGestures: true,
              child: Image(
                image: AssetImage('assets/images/image.png'),
                height: h(context) * .2,
                width: w(context) * .2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
