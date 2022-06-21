import 'package:flutter/material.dart';

class BackgroundShapes extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final height = size.height;
    final width = size.width;

    Paint orangePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = const Color.fromRGBO(253, 131, 32, 1);

    Paint bluePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = const Color.fromRGBO(0, 55, 186, 1);

    Path bluePath = Path();
    bluePath.moveTo(width, 0);
    bluePath.lineTo(width, height * 0.70);
    bluePath.quadraticBezierTo(width * 0.5, height * 0.9, width * 0.2, 0);

    canvas.drawPath(bluePath, bluePaint);

    Path orangePath = Path();
    orangePath.lineTo(width * 0.6, 0);
    orangePath.quadraticBezierTo(width * 0.8, height * 0.6, 0, height);

    canvas.drawPath(orangePath, orangePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
