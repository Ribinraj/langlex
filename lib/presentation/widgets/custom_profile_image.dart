import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';

class CustomRoundImage extends StatelessWidget {
  const CustomRoundImage({
    super.key,
    required this.circleContainerSize,
    required this.imageUrl,
  });
  final String imageUrl;
  final double circleContainerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleContainerSize,
      width: circleContainerSize,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Appcolors.kgreenColor),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: UnconstrainedBox(
        child: ClipOval(
          child: Container(
            height: circleContainerSize - 5,
            width: circleContainerSize - 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
