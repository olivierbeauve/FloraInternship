import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/step-0/widget/header-step.dart';
import 'package:flutter/material.dart';

class Step2State extends State<Step2View> {
  Widget build(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          child: Column(
            children: [
              HeaderStep(text: 'subscription.header_text_2'),
              Padding(padding: const EdgeInsets.only(top: 96)),
              containerWithIconAndText(
                  icon: SvgIcons.PROFIL,
                  firstText: 'subscription.text_5',
                  secondText: 'subscription.text_6'),
              Padding(padding: const EdgeInsets.only(top: 16)),
              containerWithIconAndText(
                  icon: SvgIcons.PHONE,
                  firstText: 'subscription.text_7',
                  secondText: 'subscription.text_8'),
              Padding(padding: EdgeInsets.only(bottom: 88)),
            ],
          ),
        )
      ],
    );
  }

  Widget containerWithIconAndText(
      {String icon, String firstText, String secondText}) {
    return Container(
      width: 358,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 26),
                child: CircleAvatar(
                    backgroundColor: KitUIColors.NEUTRAL_10,
                    radius: 28,
                    child: icon.toIcon()),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 26),
                child: H5(
                  allTranslations.text(firstText),
                  color: KitUIColors.BLACK,
                  fontWeight: FontWeightEnum.Bold,
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 26, bottom: 18),
                child: Small(
                  allTranslations.text(secondText),
                  color: KitUIColors.NEUTRAL_80,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: KitUIColors.NEUTRAL_10, width: 6),
          borderRadius: new BorderRadius.all(Radius.circular(8))),
    );
  }
}

class Step2View extends StatefulWidget {
  @override
  Step2State createState() => Step2State();
}
