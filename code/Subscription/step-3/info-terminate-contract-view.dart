import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-3/already-assured-view.dart';
import 'package:flora/subscription/step-3/moving-date-contract-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoTerminateContractView extends StatefulWidget {
  static const String ROUTE_NAME = '/info-terminate-contract';
  static const int INDEX = 5;

  @override
  _InfoTerminateContractState createState() => _InfoTerminateContractState();
}

class _InfoTerminateContractState extends State<InfoTerminateContractView> {
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
                      allTranslations.text('subscription_step.contract.title'),
                      color: KitUIColors.NEUTRAL_100,
                      fontWeight: FontWeightEnum.Bold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Container(
                    width: 358,
                    child: P(
                      allTranslations
                          .text('subscription_step.contract.description'),
                      color: KitUIColors.NEUTRAL_70,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ])
              ]),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexSubscription(MovingDateContractView.INDEX),
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexSubscription(AlreadyAssuredView.INDEX),
                )),
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
