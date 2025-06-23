import 'dart:io';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';

class CustomEditprofileContainer extends StatelessWidget {
  const CustomEditprofileContainer({
    super.key,
    required this.circleContainerSize,
    required this.imageFile,
  });

  final String imageFile;
  final double circleContainerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleContainerSize,
      width: circleContainerSize,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Appcolors.kprimarycolor),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: UnconstrainedBox(
        child: ClipOval(
          child: Container(
            height: circleContainerSize - 5,
            width: circleContainerSize - 5,
            decoration: BoxDecoration(
              //color: Appcolors.kgreycolor,
              image: imageFile.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(imageFile)),
                    )
                  : null,
            ),
            child: imageFile.isEmpty
                ? Icon(
                    Icons.person, // Use any icon you prefer here
                    size: circleContainerSize / 2,
                    color: Appcolors.kprimarycolor,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
