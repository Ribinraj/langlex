import 'package:flutter/material.dart';

///responsive
double responsiveTextSize(BuildContext context, double scaleFactor) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  double basis = screenHeight + screenWidth;

  return basis * scaleFactor;
}

double responsiveRadius(BuildContext context, double scaleFactor) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  double basis = screenHeight + screenWidth;

  return basis * scaleFactor;
}

double h(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double w(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
////texts

class AppDimensions {
  static double fontSize10(
    BuildContext context,
  ) =>
      responsiveTextSize(context, .0067); ////10.0;
  static double fontSize12(
    BuildContext context,
  ) =>
      responsiveTextSize(context, .0088); ////12.0;
  static double fontSize13(
    BuildContext context,
  ) =>
      responsiveTextSize(context, .0099);

  ///13
  static double fontSize15(BuildContext context) =>
      responsiveTextSize(context, .011); ////15.0;
  static double fontSize16(BuildContext context) =>
      responsiveTextSize(context, .0117); //// 16.0;
  static double fontSize17(BuildContext context) =>
      responsiveTextSize(context, .0125); ////17.0;
  static double fontSize18(BuildContext context) =>
      responsiveTextSize(context, .0132); ////18.0;
  static double fontSize20(BuildContext context) =>
      responsiveTextSize(context, .0152);
  static double fontSize24(BuildContext context) =>
      responsiveTextSize(context, .0175); ////24.0;
  static double fontSize25(BuildContext context) =>
      responsiveTextSize(context, .0183); ////25.0;
  static double fontSize30(BuildContext context) =>
      responsiveTextSize(context, .0235);

  static double fontSizeLarge(BuildContext context) =>
      responsiveTextSize(context, .03); //34
  static double fontSizeOverLarge(BuildContext context) =>
      responsiveTextSize(context, .032); // 34.0;
  static double fontSizeMaxLarge(BuildContext context) =>
      responsiveTextSize(context, .0335);
  static double fontSizeExtraLarge(BuildContext context) =>
      responsiveTextSize(context, .035); //45.0;

  static const double paddingSize5 = 5.0;
  static const double paddingSize10 = 10.0;
  static const double paddingSize15 = 15.0;
  static const double paddingSize20 = 20.0;
  static const double paddingSize25 = 25.0;

  static const double radiusSize5 = 5.0;
  static const double radiusSize8 = 8.0;
  static const double radiusSize10 = 10.0;
  static const double radiusSize15 = 15.0;
  static const double radiusSize20 = 20.0;
  //
  static BorderRadius kradius5 = BorderRadius.circular(5);
  static BorderRadius kradius10 = BorderRadius.circular(10);
  static BorderRadius kradius15 = BorderRadius.circular(15);
  static BorderRadius kradius20 = BorderRadius.circular(20);
  static BorderRadius kradius30 = BorderRadius.circular(30);

  /////
}

const backgroundimage = "assets/images/langlex_bkp.png";
const logo = 'assets/images/logo.png';
const numberimage = 'assets/images/number.png';
