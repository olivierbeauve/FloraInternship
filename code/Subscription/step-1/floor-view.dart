import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-1/address-view.dart';
import 'package:flora/subscription/step-1/housing-type-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorView extends StatefulWidget {
  static const String ROUTE_NAME = '/floor';
  static const int INDEX = 1;

  @override
  _FloorState createState() => _FloorState();
}

class _FloorState extends State<FloorView> {
  bool groundFloorState;
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
                          allTranslations.text('floor.sub_title'),
                          color: KitUIColors.NEUTRAL_100,
                          fontWeight: FontWeightEnum.Bold,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  containerWithIconAndText(
                      icon: SvgIcons.ZERO,
                      firstText: 'floor.choice_1',
                      groundFloor: true),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  containerWithIconAndText(
                      icon: SvgIcons.ONE_PLUS,
                      firstText: 'floor.choice_2',
                      groundFloor: false),
                ],
              ),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexQuote(AddressView.INDEX),
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexQuote(HousingTypeView.INDEX),
                  isDisable: !isSelected,
                )),
          ],
        ),
      ),
    );
  }

  Widget containerWithIconAndText(
      {String icon, String firstText, bool groundFloor}) {
    return Align(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            groundFloorState = groundFloor;
            isSelected = true;
          });
          Provider.of<SubscriptionProvider>(context, listen: false)
              .groundFloor = groundFloor;
          await Future.delayed(const Duration(milliseconds: 200), () {});
          Provider.of<SubscriptionProvider>(context, listen: false)
              .setIndexQuote(AddressView.INDEX);
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
                fontWeight:
                    groundFloorState != null && groundFloorState == groundFloor
                        ? FontWeightEnum.Bold
                        : FontWeightEnum.Medium,
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: groundFloorState != null && groundFloorState == groundFloor
                  ? KitUIColors.PRIMARY_05
                  : KitUIColors.WHITE,
              border: Border.all(
                  color: groundFloorState != null &&
                          groundFloorState == groundFloor
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
    groundFloorState =
        Provider.of<SubscriptionProvider>(context, listen: false).groundFloor;
    isSelected = (groundFloorState != null);
  }
}
