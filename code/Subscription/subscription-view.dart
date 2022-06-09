import 'package:dots_indicator/dots_indicator.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view.dart';
import 'package:flora/subscription/step-0/step1-view.dart';
import 'package:flora/subscription/step-0/step2-view.dart';
import 'package:flora/subscription/step-0/step3-view.dart';
import 'package:flora/subscription/step-0/step4-view.dart';
import 'package:flutter/material.dart';

class SubscriptionView extends StatefulWidget {
  static const String ROUTE_NAME = '/subscription';

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionView> {
  final totalDots = 4;
  double curr = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: Stack(
      children: [
        PageView(
          children: [Step1View(), Step2View(), Step3View(), Step4View()],
          onPageChanged: (num) {
            setState(() {
              curr = num.toDouble();
            });
          },
        ),
        Positioned(bottom: 32, right: 0, left: 0, child: dots()),
      ],
    ));
  }

  Widget dots() {
    return DotsIndicator(
      dotsCount: totalDots,
      position: curr,
      decorator: DotsDecorator(
          activeColor: KitUIColors.PRIMARY_50,
          size: Size.square(13),
          activeSize: Size.square(12),
          color: KitUIColors.WHITE,
          spacing: EdgeInsets.only(left: 7.75, right: 7.75),
          shape: CircleBorder(side: BorderSide(color: KitUIColors.PRIMARY_50))),
    );
  }
}
