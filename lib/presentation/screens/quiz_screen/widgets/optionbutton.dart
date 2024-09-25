// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_button/flutter_swipe_button.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';

// class SwipeAnswerWidget extends StatelessWidget {
//   const SwipeAnswerWidget({
//     super.key,
//     required this.onswipe,
//     required this.text,
//   });
//   final VoidCallback onswipe;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return SwipeButton.expand(
//       thumb: const Icon(
//         Icons.double_arrow_rounded,
//         color: Colors.white,
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//             color: Appcolors.kwhiteColor,
//             fontSize: AppDimensions.fontSize18(context),
//             fontWeight: FontWeight.bold),
//       ),
//       enabled: true,
//       activeThumbColor: Appcolors.kgreenlightColor,
//       activeTrackColor: Appcolors.kgreenColor,
//       onSwipe: onswipe,
//     );
//   }
// }
