import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0012500, size.height * 0.4980000);
    path0.lineTo(size.width * 0.0450000, size.height * 0.5220000);
    path0.lineTo(size.width * 0.1000000, size.height * 0.5540000);
    path0.lineTo(size.width * 0.1687500, size.height * 0.5800000);
    path0.lineTo(size.width * 0.2937500, size.height * 0.5500000);
    path0.lineTo(size.width * 0.4150000, size.height * 0.4720000);
    path0.lineTo(size.width * 0.4737500, size.height * 0.4480000);
    path0.lineTo(size.width * 0.5600000, size.height * 0.4560000);
    path0.lineTo(size.width * 0.6037500, size.height * 0.4780000);
    path0.lineTo(size.width * 0.6950000, size.height * 0.5360000);
    path0.lineTo(size.width * 0.7937500, size.height * 0.5800000);
    path0.lineTo(size.width * 0.8725000, size.height * 0.5900000);
    path0.lineTo(size.width * 0.9250000, size.height * 0.5560000);
    path0.lineTo(size.width, size.height * 0.4740000);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.4980000);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}