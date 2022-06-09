import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  double width;
  final double height = 56;

  HeaderPainter({this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = KitUIColors.PRIMARY_50
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, this.height * 0.70);
    path0.lineTo(this.width * 0.25, this.height);
    path0.lineTo(this.width, this.height * 0.60);
    path0.lineTo(this.width, 0);
    path0.lineTo(0, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
