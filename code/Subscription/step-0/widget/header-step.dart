import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/step-0/widget/header-painter.dart';
import 'package:flutter/material.dart';

class HeaderStep extends StatelessWidget {
  final String text;

  HeaderStep({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: KitUIColors.PRIMARY_50,
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 53.6)),
          Center(
              child:
                  Image.asset('assets/images/white-ethias.png', width: 120.26)),
          Padding(padding: EdgeInsets.only(top: 33.6)),
          H4(
            allTranslations.text(text),
            color: KitUIColors.WHITE,
            fontWeight: FontWeightEnum.Bold,
            textAlign: TextAlign.center,
          ),
          CustomPaint(
            child: Container(
              height: 1,
            ),
            painter: HeaderPainter(width: MediaQuery.of(context).size.width),
          )
        ]));
  }
}
