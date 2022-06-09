import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/step-0/widget/header-step.dart';
import 'package:flutter/material.dart';

class Step3State extends State<Step3View> {
  Widget build(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderStep(text: 'subscription.header_text_3'),
        Padding(padding: EdgeInsets.only(top: 96)),
        rowOfIcons(
            firstIcon: SvgIcons.FIRE,
            firstText: 'subscription.text_9',
            secondIcon: SvgIcons.WATER,
            secondText: 'subscription.text_10',
            thirdIcon: SvgIcons.SNOW,
            thirdText: 'subscription.text_11'),
        Padding(padding: EdgeInsets.only(top: 24)),
        rowOfIcons(
            firstIcon: SvgIcons.VANDAL,
            firstText: 'subscription.text_12',
            secondIcon: SvgIcons.FLOOD,
            secondText: 'subscription.text_13',
            thirdIcon: SvgIcons.BOLT,
            thirdText: 'subscription.text_14'),
        Padding(padding: const EdgeInsets.only(top: 24)),
        Small(
          allTranslations.text('subscription.text_15'),
          color: KitUIColors.NEUTRAL_80,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              P(
                allTranslations.text('subscription.text_16'),
                color: KitUIColors.BLACK,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
        rowWithIconAndText(text: 'subscription.text_17'),
        rowWithIconAndText(text: 'subscription.text_18'),
        rowWithIconAndText(text: 'subscription.text_19'),
        rowWithIconAndText(text: 'subscription.text_20'),
        rowWithIconAndText(text: 'subscription.text_21'),
        Padding(padding: const EdgeInsets.only(top: 16)),
        P(
          allTranslations.text('subscription.text_22'),
          color: KitUIColors.PRIMARY_50,
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.only(bottom: 72)),
      ],
    );
  }

  Widget iconWithSmallText({String text, String svgIcon}) {
    return Container(
      width: 108,
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: KitUIColors.NEUTRAL_10,
              radius: 28,
              child: svgIcon.toIcon()),
          Padding(padding: EdgeInsets.only(top: 8)),
          Small(
            allTranslations.text(text),
            color: KitUIColors.BLACK,
          )
        ],
      ),
    );
  }

  Widget rowOfIcons(
      {String firstIcon,
      String firstText,
      String secondIcon,
      String secondText,
      String thirdIcon,
      String thirdText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconWithSmallText(text: firstText, svgIcon: firstIcon),
        Padding(padding: const EdgeInsets.only(left: 16.0)),
        iconWithSmallText(text: secondText, svgIcon: secondIcon),
        Padding(padding: const EdgeInsets.only(left: 16.0)),
        iconWithSmallText(text: thirdText, svgIcon: thirdIcon)
      ],
    );
  }

  Widget rowWithIconAndText({String text}) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16),
      height: 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgIcons.CROSS.toIcon(color: KitUIColors.ERROR_30),
          Padding(padding: const EdgeInsets.only(left: 13.58)),
          Small(
            allTranslations.text(text),
            color: KitUIColors.BLACK,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}

class Step3View extends StatefulWidget {
  @override
  Step3State createState() => Step3State();
}
