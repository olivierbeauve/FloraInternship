import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/login/login-view.dart';
import 'package:flora/subscription/step-0/widget/header-step.dart';
import 'package:flora/subscription/subscription-first-step-view.dart';
import 'package:flutter/material.dart';

class Step4State extends State<Step4View> {
  Widget build(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderStep(text: 'subscription.header_text_4'),
        Padding(padding: EdgeInsets.only(top: 96)),
        P(
          allTranslations.text('subscription.text_23'),
          color: KitUIColors.BLACK,
          fontWeight: FontWeightEnum.Bold,
          textAlign: TextAlign.center,
        ),
        Padding(padding: const EdgeInsets.only(top: 24)),
        P(
          allTranslations.text('subscription.text_24'),
          color: KitUIColors.BLACK,
          textAlign: TextAlign.center,
        ),
        Padding(padding: const EdgeInsets.only(top: 16)),
        Align(
          child: Container(
            width: 358,
            height: 40,
            child: BtnPrimaryBase(
              text: allTranslations.text('subscription.text_25'),
              onPressed: () => Navigator.of(context)
                  .pushNamed(SubscriptionFirstStepView.ROUTE_NAME),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 292)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            P(
              allTranslations.text('subscription.text_26'),
              color: KitUIColors.BLACK,
            ),
            Padding(padding: const EdgeInsets.only(left: 8)),
            GestureDetector(
              child: P(
                allTranslations.text('subscription.text_27'),
                color: KitUIColors.PRIMARY_50,
              ),
              onTap: () => Navigator.of(context).pushNamed(Login.ROUTE_NAME),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 68)),
      ],
    );
  }
}

class Step4View extends StatefulWidget {
  @override
  Step4State createState() => Step4State();
}
