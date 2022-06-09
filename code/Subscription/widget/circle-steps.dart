import 'dart:math' as math;

import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flutter/material.dart';

class CircleSteps extends CustomPainter {
  double pi = math.pi;
  int step;

  CircleSteps({this.step});
  double getRadians(double value) {
    return (360 * value) * pi / 180;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4;
    Rect myRect = const Offset(1, 1) & const Size(42.0, 42.0);

    var paint2 = Paint()
      ..color = KitUIColors.NEUTRAL_10
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    var paint3 = Paint()
      ..color = KitUIColors.PRIMARY_50
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double firstLineRadianEnd = getRadians(3 / 4);
    double secondLineRadianEnd = getRadians(step / 4);
    canvas.drawArc(myRect, 0, firstLineRadianEnd, false, paint2);
    canvas.drawArc(
        myRect, firstLineRadianEnd, secondLineRadianEnd, false, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
