import 'package:flutter/material.dart';

class MusicProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final double dotSize;
  
  const MusicProgressBar({
    super.key,
    required this.progress,
    this.activeColor = Colors.blue,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.height = 3.0,
    this.dotSize = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dotSize, // Container height matches dot size for proper centering
      child: Stack(
        alignment: Alignment.center, // Center everything vertically
        children: [
          // Background track
          Container(
            height: height,
            decoration: BoxDecoration(
              color: inactiveColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          
          // Active progress
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Active progress line
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: height,
                      width: constraints.maxWidth * progress,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(height / 2),
                      ),
                    ),
                  ),
                  
                  // Dot handle
                  Positioned(
                    left: (constraints.maxWidth * progress) - (dotSize / 2),
                    top: (dotSize - height) / 2, // Centers dot vertically relative to line
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: activeColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: activeColor.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}