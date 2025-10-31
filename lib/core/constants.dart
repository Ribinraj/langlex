



import 'package:flutter/material.dart';
import 'package:langlex/core/responsive_utils.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double? sizeFactor;
  final FontWeight? weight;
  final Color? color;

  const ResponsiveText(
    this.text, {
    super.key,
    this.sizeFactor,
    this.weight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Base size is 4% of screen width
    final baseSize = ResponsiveUtils.sp(4);

    return Text(
      text,
      style: TextStyle(
        fontSize: sizeFactor != null ? baseSize * sizeFactor! : baseSize,
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black,
      ),
    );
  }
}

// Optional: Predefined text styles
class TextStyles {
  static ResponsiveText headline(
      {String? text, FontWeight? weight, Color? color}) {
    return ResponsiveText(
      text ?? '',
      sizeFactor: 1.5, // 50% larger than base size
      weight: weight ?? FontWeight.bold,
      color: color,
    );
  }

  static ResponsiveText subheadline(
      {String? text, FontWeight? weight, Color? color}) {
    return ResponsiveText(
      text ?? '',
      sizeFactor: 1.22,
      weight: weight ?? FontWeight.w600,
      color: color,
    );
  }

  static ResponsiveText body({String? text, FontWeight? weight, Color? color}) {
    return ResponsiveText(
      text ?? '',
      sizeFactor: .9, // base size
      weight: weight,
      color: color,
    );
  }

  static ResponsiveText medium(
      {String? text, FontWeight? weight, Color? color}) {
    return ResponsiveText(
      text ?? '',
      sizeFactor: .82, // base size
      weight: weight,
      color: color,
    );
  }

  static ResponsiveText caption(
      {String? text, FontWeight? weight, Color? color}) {
    return ResponsiveText(
      text ?? '',
      sizeFactor: 0.74, // 25% smaller than base size
      weight: weight,
      color: color ?? Colors.grey[600],
    );
  }
}
///////
// Basic usage
// ResponsiveText(
//   'Hello, World!',
//   sizeFactor: 1.5, // 50% larger than base size
//   weight: FontWeight.bold,
//   color: Colors.blue,
// )

// // Using predefined styles
// TextStyles.headline(text: 'Main Title')

// TextStyles.subheadline(
//   text: 'Subtitle',
//   color: Colors.grey,
// )

// TextStyles.body(
//   text: 'This is the body text.',
//   weight: FontWeight.w300,
// )

// TextStyles.caption(text: 'Small caption text')

// // Custom sizing
// ResponsiveText(
//   'Custom sized text',
//   sizeFactor: 2.0, // Twice the base size
// )
//////////////////////////
//  Text(
//               'Welcome to our responsive app!',
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.sp(6),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
/////////////------------------borderradius-----------------/////////////////

class ResponsiveBorderRadius {
  final double? sizeFactor;

  const ResponsiveBorderRadius({this.sizeFactor});

  BorderRadius getBorderRadius() {
    // Base size is 1% of screen width
    final baseSize = ResponsiveUtils.borderRadius(1);

    return BorderRadius.circular(
      sizeFactor != null ? baseSize * sizeFactor! : baseSize,
    );
  }
}

// Predefined border radius styles
class BorderRadiusStyles {
  static BorderRadius kradius5() {
    return const ResponsiveBorderRadius(sizeFactor: 1.25).getBorderRadius();
  }

  static BorderRadius kradius10() {
    return const ResponsiveBorderRadius(sizeFactor: 2.5).getBorderRadius();
  }

  static BorderRadius kradius15() {
    return const ResponsiveBorderRadius(sizeFactor: 3.75).getBorderRadius();
  }

  static BorderRadius kradius20() {
    return const ResponsiveBorderRadius(sizeFactor: 5).getBorderRadius();
  }

  static BorderRadius kradius30() {
    return const ResponsiveBorderRadius(sizeFactor: 7.5).getBorderRadius();
  }

  static BorderRadius custom({double? sizeFactor}) {
    return ResponsiveBorderRadius(sizeFactor: sizeFactor).getBorderRadius();
  }
}
/////
// Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadiusStyles.kradius10(),
//     color: Colors.blue,
//   ),
//   child: Text('Hello, World!'),
// )

// // Or for a custom size:
// Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadiusStyles.custom(sizeFactor: 4.0),
//     color: Colors.green,
//   ),
//   child: Text('Custom radius'),
// )
//////////////-------sizedbox---------------////////////

class ResponsiveSizedBox {
  // Height constants
  static SizedBox height5 = SizedBox(height: ResponsiveUtils.hp(0.5));
  static SizedBox height10 = SizedBox(height: ResponsiveUtils.hp(1));
  static SizedBox height20 = SizedBox(height: ResponsiveUtils.hp(2));
  static SizedBox height30 = SizedBox(height: ResponsiveUtils.hp(3));
  static SizedBox height50 = SizedBox(height: ResponsiveUtils.hp(5));

  // Width constants
  static SizedBox width5 = SizedBox(width: ResponsiveUtils.wp(1.25));
  static SizedBox width10 = SizedBox(width: ResponsiveUtils.wp(2.5));
  static SizedBox width20 = SizedBox(width: ResponsiveUtils.wp(5));
  static SizedBox width30 = SizedBox(width: ResponsiveUtils.wp(7.5));
  static SizedBox width50 = SizedBox(width: ResponsiveUtils.wp(12.5));

  // Custom methods for dynamic sizes
  static SizedBox height(double percentage) {
    return SizedBox(height: ResponsiveUtils.hp(percentage));
  }

  static SizedBox width(double percentage) {
    return SizedBox(width: ResponsiveUtils.wp(percentage));
  }
}
const backgroundimage = "assets/images/langlex_bkp.png";
const logo = 'assets/images/logo.png';
const numberimage = 'assets/images/number.png';
const profilebackgroundimage = 'assets/images/profilebackground.jpeg';
