

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

class AppStyle {
  static TextStyle robotoStyle(
      {double? size,
      required BuildContext context,
      bool? enableShadow,
      Color? shadowColor,
      FontWeight? fontWeight,
      double? letterSpacing,
      Color? color}) {
    return GoogleFonts.roboto(
        shadows: [
          enableShadow != null
              ? Shadow(
                  offset: const Offset(1, 2),
                  color: shadowColor ?? Appcolors.kblackColor.withOpacity(.3))
              : const Shadow()
        ],
        color: color,
        fontWeight: fontWeight,
        fontSize: size ?? AppDimensions.fontSize12(context),
        letterSpacing: letterSpacing);
  }
}
