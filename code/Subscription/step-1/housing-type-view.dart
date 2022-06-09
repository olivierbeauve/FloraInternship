import 'package:enum_to_string/enum_to_string.dart';
import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/document/contract/termination/termination-request.dart';
import 'package:flora/subscription/step-1/address-view.dart';
import 'package:flora/subscription/step-1/floor-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HousingTypeView extends StatefulWidget {
  static const String ROUTE_NAME = '/type_home';
  static const int INDEX = 0;

  @override
  _TypeHomeState createState() => _TypeHomeState();
}

class _TypeHomeState extends State<HousingTypeView> {
  HOUSING_TYPE typeState;
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
                          allTranslations.text('type_home.sub_title'),
                          color: KitUIColors.NEUTRAL_100,
                          fontWeight: FontWeightEnum.Bold,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  containerWithIconAndText(
                      icon: SvgIcons.APPARTMENT,
                      firstText: 'type_home.choice_1',
                      type: HOUSING_TYPE.Apartment),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  containerWithIconAndText(
                      icon: SvgIcons.HOUSE,
                      firstText: 'type_home.choice_2',
                      type: HOUSING_TYPE.House),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  containerWithIconAndText(
                      icon: SvgIcons.VILLA,
                      firstText: 'type_home.choice_3',
                      type: HOUSING_TYPE.Villa),
                ],
              ),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: () => typeState == HOUSING_TYPE.Apartment
                      ? Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .setIndexQuote(FloorView.INDEX)
                      : Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .setIndexQuote(AddressView.INDEX),
                  onPressedPrevious: () => Navigator.pop(context),
                  isLoading: false,
                  isDisable: !isSelected,
                )),
          ],
        ),
      ),
    );
  }

  Widget containerWithIconAndText(
      {String icon, String firstText, HOUSING_TYPE type}) {
    return Align(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            typeState = type;
            isSelected = true;
          });
          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .property
              .type = EnumToString.convertToString(type);
          await Future.delayed(const Duration(milliseconds: 200), () {});
          typeState == HOUSING_TYPE.Apartment
              ? Provider.of<SubscriptionProvider>(context, listen: false)
                  .setIndexQuote(FloorView.INDEX)
              : Provider.of<SubscriptionProvider>(context, listen: false)
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
                fontWeight: typeState != null && typeState == type
                    ? FontWeightEnum.Bold
                    : FontWeightEnum.Medium,
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: typeState != null && typeState == type
                  ? KitUIColors.PRIMARY_05
                  : KitUIColors.WHITE,
              border: Border.all(
                  color: typeState != null && typeState == type
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
    if (Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .property
            .type !=
        null) {
      typeState = EnumToString.fromString(
          HOUSING_TYPE.values,
          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .property
              .type);
    }

    if (typeState != null) {
      isSelected = true;
    }
  }
}
