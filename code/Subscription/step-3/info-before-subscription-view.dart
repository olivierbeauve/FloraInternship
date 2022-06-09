import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-3/already-assured-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoBeforeSubscriptionView extends StatefulWidget {
  static const String ROUTE_NAME = '/info-before-subscription';
  static const int INDEX = 0;

  @override
  _InfoBeforeSubscriptionState createState() => _InfoBeforeSubscriptionState();
}

class _InfoBeforeSubscriptionState extends State<InfoBeforeSubscriptionView> {
  Widget build(context) {
    return BaseView(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
                Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    width: 358,
                    child: H5(
                      allTranslations.text('subscription_step.sub_title'),
                      color: KitUIColors.NEUTRAL_100,
                      fontWeight: FontWeightEnum.Bold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Container(
                    width: 358,
                    child: P(
                      allTranslations.text('subscription_step.description'),
                      color: KitUIColors.NEUTRAL_70,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ])
              ]),
            ),
            ChatOpening(),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 32),
              child: Column(
                children: [
                  Container(
                    width: 358,
                    height: 48,
                    child: BtnPrimaryBase(
                        text: allTranslations
                            .text("subscription_step.subscribe_btn"),
                        onPressed: () => Provider.of<SubscriptionProvider>(
                                context,
                                listen: false)
                            .setIndexSubscription(AlreadyAssuredView.INDEX)),
                  ),
                  Container(
                    width: 358,
                    height: 48,
                    child: BtnTertiaryBase(
                      text: allTranslations.text("type_home.previous"),
                      onTap: () => Navigator.pop(context),
                      color: KitUIColors.NEUTRAL_50,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
