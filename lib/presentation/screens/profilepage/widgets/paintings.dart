import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double animationValue;

  WavePainter({
    required this.color1,
    required this.color2,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color1, color2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final waveHeight =
        size.height * 0.12; // Increased wave height for larger waves
    final waveLength = size.width * 1.5; // Larger wave length for bigger waves

    path.moveTo(0, 0);
    path.lineTo(0, size.height - waveHeight);

    // Create large flowing wave pattern with smaller curves
    for (double x = 0; x <= size.width; x++) {
      final y = size.height -
          waveHeight +
          // Main large wave with smaller curve
          math.sin((x / waveLength) * 2 * math.pi + animationValue * 1.5) * 20 +
          // Secondary wave for subtle variation
          math.sin((x / (waveLength * 1.2)) * 1.5 * math.pi +
                  animationValue * 1.2) *
              8;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Enhanced Custom Painter for decorative elements with faster animation
class CircleDecorPainter extends CustomPainter {
  final double animationValue;

  CircleDecorPainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Enhanced floating elements with faster movement
    final elements = [
      {
        'x': size.width * 0.85,
        'y': size.height * 0.15,
        'radius': 25.0,
        'speed': 1.2 // Increased speed
      },
      {
        'x': size.width * 0.12,
        'y': size.height * 0.65,
        'radius': 18.0,
        'speed': 1.6 // Increased speed
      },
      {
        'x': size.width * 0.88,
        'y': size.height * 0.75,
        'radius': 22.0,
        'speed': 0.9 // Increased speed
      },
      {
        'x': size.width * 0.25,
        'y': size.height * 0.08,
        'radius': 12.0,
        'speed': 1.8 // Increased speed
      },
      {
        'x': size.width * 0.65,
        'y': size.height * 0.35,
        'radius': 15.0,
        'speed': 1.3 // Increased speed
      },
      {
        'x': size.width * 0.05,
        'y': size.height * 0.25,
        'radius': 8.0,
        'speed': 2.0 // Increased speed
      },
    ];

    for (var element in elements) {
      final speed = element['speed'] as double;
      final offset = Offset(
        element['x']! +
            math.sin(animationValue * speed + element['y']! / 300) *
                6, // Increased movement range
        element['y']! +
            math.cos(animationValue * speed * 0.8 + element['x']! / 300) *
                4, // Increased movement range
      );

      // Draw filled circle
      canvas.drawCircle(offset, element['radius']!, paint);
      // Draw stroke circle for better definition
      canvas.drawCircle(offset, element['radius']!, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}