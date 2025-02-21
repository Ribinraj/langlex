import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

// class CustomLanguageContainer extends StatelessWidget {
//   const CustomLanguageContainer({
//     super.key,
//     required this.languageText,
//     required this.heroTag,
//   });

//   final String languageText;
//   final String heroTag;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Container(
//         height: ResponsiveUtils.hp(6.5),
//         decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Appcolors.kgreenColor,
//                 Color.fromARGB(255, 99, 233, 179)
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(
//                 width: .5, color: const Color.fromARGB(255, 120, 179, 162))),
//         child: Center(
//           child: Text(
//             languageText,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.fredoka(
//               fontSize: ResponsiveUtils.wp(4),
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//               shadows: [
//                 Shadow(
//                   blurRadius: 3.0,
//                   color: Colors.black.withOpacity(0.5),
//                   offset: const Offset(2, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.kwhiteColor,
        // gradient: const LinearGradient(
        //   colors: [
        //     Appcolors.kgreenColor,
        //     Color.fromARGB(255, 99, 233, 179)
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.2, color: Appcolors.kborderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.language,
            size: ResponsiveUtils.wp(9),
            color: Appcolors.kgreenColor,
          ),
          ResponsiveSizedBox.height10,
          Text(
            languageText,
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              fontSize: ResponsiveUtils.wp(4.5),
              fontWeight: FontWeight.w500,
              color: Appcolors.kgreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
