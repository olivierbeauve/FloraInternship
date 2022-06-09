import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-3/info-before-subscription-view.dart';
import 'package:flora/subscription/step-3/info-terminate-contract-view.dart';
import 'package:flora/subscription/step-3/moving-date-contract-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlreadyAssuredView extends StatefulWidget {
  static const String ROUTE_NAME = '/already_assured';
  static const int INDEX = 1;

  @override
  _AlreadyAssuredState createState() => _AlreadyAssuredState();
}

class _AlreadyAssuredState extends State<AlreadyAssuredView> {
  bool alreadyAssuredState;
  bool isSelected = false;

  Widget build(context) {
    return BaseView(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        width: 358,
                        child: H5(
                          allTranslations.text(
                              'subscription_step.subscribe.already_assured_title'),
                          color: KitUIColors.NEUTRAL_100,
                          fontWeight: FontWeightEnum.Bold,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Container(
                        width: 358,
                        child: P(
                          allTranslations.text(
                              'subscription_step.subscribe.already_assured_description'),
                          color: KitUIColors.NEUTRAL_70,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  containerWithIconAndText(
                      icon: SvgIcons.ZERO,
                      firstText: 'subscription_step.subscribe.yes',
                      alreadyAssured: true),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  containerWithIconAndText(
                      icon: SvgIcons.ONE_PLUS,
                      firstText: 'subscription_step.subscribe.not_yet',
                      alreadyAssured: false),
                ],
              ),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: () => {
                    !alreadyAssuredState
                        ? Provider.of<SubscriptionProvider>(context,
                                listen: false)
                            .setIndexSubscription(MovingDateContractView.INDEX)
                        : Provider.of<SubscriptionProvider>(context,
                                listen: false)
                            .setIndexSubscription(
                                InfoTerminateContractView.INDEX),
                  },
                  onPressedPrevious: () => Provider.of<SubscriptionProvider>(
                          context,
                          listen: false)
                      .setIndexSubscription(InfoBeforeSubscriptionView.INDEX),
                  isDisable: !isSelected,
                )),
          ],
        ),
      ),
    );
  }

  Widget containerWithIconAndText(
      {String icon, String firstText, bool alreadyAssured}) {
    return Align(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            alreadyAssuredState = alreadyAssured;
            isSelected = true;
          });
          Provider.of<SubscriptionProvider>(context, listen: false)
              .alreadyAssured = alreadyAssured;
          await Future.delayed(const Duration(milliseconds: 200), () {});
          if (!alreadyAssured)
            Provider.of<SubscriptionProvider>(context, listen: false)
                .setIndexSubscription(MovingDateContractView.INDEX);
          else
            Provider.of<SubscriptionProvider>(context, listen: false)
                .setIndexSubscription(InfoTerminateContractView.INDEX);
        },
        child: Container(
          width: 358,
          height: 72,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 16)),
              icon.toIcon(color: KitUIColors.PRIMARY_50),
              Padding(padding: EdgeInsets.only(left: 8)),
              H5(
                allTranslations.text(firstText),
                color: KitUIColors.NEUTRAL_100,
                textAlign: TextAlign.left,
                fontWeight: alreadyAssuredState != null &&
                        alreadyAssuredState == alreadyAssured
                    ? FontWeightEnum.Bold
                    : FontWeightEnum.Medium,
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: alreadyAssuredState != null &&
                      alreadyAssuredState == alreadyAssured
                  ? KitUIColors.PRIMARY_05
                  : KitUIColors.WHITE,
              border: Border.all(
                  color: alreadyAssuredState != null &&
                          alreadyAssuredState == alreadyAssured
                      ? KitUIColors.PRIMARY_50
                      : KitUIColors.NEUTRAL_20,
                  width: 1),
              borderRadius: new BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    alreadyAssuredState =
        Provider.of<SubscriptionProvider>(context, listen: false)
            .alreadyAssured;
    isSelected = (alreadyAssuredState != null);
  }
}
