import 'package:flutter/material.dart';

// MultiColorProgressPainter
class MultiColorProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  MultiColorProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  // function to draw the progress bar
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final Radius radius = Radius.circular(size.height / 2);

    // Draw background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radius,
      ),
      backgroundPaint,
    );

    // Draw progress
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * percentage, size.height),
        radius,
      ),
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
