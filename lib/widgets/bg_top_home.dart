import 'package:flutter/material.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class HalfCircleCustom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.primaryColorLight;
    paint.strokeWidth = 1;
    Path path = Path();
    path.moveTo(size.width * 0.1, size.height);
    path.quadraticBezierTo(
        size.width * 0.2, size.height,
        size.width * 0.25, size.height * 0.85
    );

    path.quadraticBezierTo(
        size.width /2,
        0,
        size.width * 0.75,
        size.height *0.85);

    path.quadraticBezierTo(
        size.width * 0.8,
        size.height,
        size.width * 0.9,
        size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
