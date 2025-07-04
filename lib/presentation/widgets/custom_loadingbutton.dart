import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

class CustomLoadingElevatedButton extends StatelessWidget {
 
  const CustomLoadingElevatedButton({
    super.key,
   required this.loading,
    required this.color,
  });
  final Widget loading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
      height: ResponsiveUtils.hp(5.5),
      width: ResponsiveUtils.screenWidth,
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.wp(1.5)),
      decoration: BoxDecoration(
        color: color,
        borderRadius:BorderRadiusStyles.kradius30(),
        border: Border.all(width: .5, color: Appcolors.kprimarycolor),
      ),
      child: Center(
        child:loading,
      ),
    )
      ),
    );
  }
}