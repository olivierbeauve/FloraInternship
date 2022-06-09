import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/step-0/widget/header-step.dart';
import 'package:flutter/material.dart';

class Step1State extends State<Step1View> {
  Widget build(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderStep(text: 'subscription.header_text_1'),
        Padding(padding: EdgeInsets.only(top: 96)),
        iconWithText(text: 'subscription.text_1', svgIcon: SvgIcons.DOC_CUT),
        Padding(padding: EdgeInsets.only(top: 32)),
        iconWithText(text: 'subscription.text_2', svgIcon: SvgIcons.SMALL_CAR),
        Padding(padding: EdgeInsets.only(top: 32)),
        iconWithText(text: 'subscription.text_3', svgIcon: SvgIcons.EURO),
        Padding(padding: EdgeInsets.only(top: 4)),
        Small(
          allTranslations.text('subscription.text_4'),
          color: KitUIColors.PRIMARY_50,
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.only(bottom: 156)),
      ],
    );
  }

  Widget iconWithText({String text, String svgIcon}) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: KitUIColors.NEUTRAL_10,
              radius: 28,
              child: svgIcon.toIcon()),
          Padding(padding: EdgeInsets.only(top: 8)),
          P(
            allTranslations.text(text),
            color: KitUIColors.BLACK,
            fontWeight: FontWeightEnum.Bold,
          )
        ],
      ),
    );
  }
}

class Step1View extends StatefulWidget {
  @override
  Step1State createState() => Step1State();
}
