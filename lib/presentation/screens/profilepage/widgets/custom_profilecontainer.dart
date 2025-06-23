import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

class CustomProfileContainer extends StatelessWidget {
  const CustomProfileContainer({
    super.key,
    required this.containerText,
    required this.icon,
  });
  final String containerText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.hp(6),
      // width: ResponsiveUtils.wp(80),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 235, 228, 228), // Start color (bottom)
              Appcolors.kwhiteColor, // End color (top)
            ],
          ),
          borderRadius: BorderRadius.circular(5),
          // borderRadius: const BorderRadius.only(
          //     topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          border: Border.all(
              width: .5, color: Appcolors.kprimarycolor.withOpacity(.7))),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            ResponsiveSizedBox.width10,
            TextStyles.medium(
              text: containerText,
              weight: FontWeight.bold,
            ),
            const Spacer(),
            const Icon(CupertinoIcons.chevron_forward)
          ],
        ),
      ),
    );
  }
}
