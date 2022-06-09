import 'package:enum_to_string/enum_to_string.dart';
import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/document/contract/termination/termination-request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HousingInfo extends StatelessWidget {
  HousingInfo();

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: KitUIColors.WHITE,
            borderRadius: new BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: KitUIColors.NEUTRAL_10,
                spreadRadius: 0,
                blurRadius: 16,
                offset: Offset(0, 0),
              ),
            ],
          ),
          width: 358,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    children: [
                      rowTwoTexts(
                          firstText: 'summary.type_house',
                          secondText: EnumToString.fromString(
                                  HOUSING_TYPE.values,
                                  Provider.of<SubscriptionProvider>(context,
                                          listen: false)
                                      .request
                                      .property
                                      .type)
                              .toTranslatedString()),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: rowTwoTexts(
                            firstText: 'summary.address',
                            secondText: Provider.of<SubscriptionProvider>(
                                        context,
                                        listen: false)
                                    .request
                                    .contact
                                    .address
                                    .streetName +
                                " " +
                                Provider.of<SubscriptionProvider>(context,
                                        listen: false)
                                    .request
                                    .contact
                                    .address
                                    .streetNumber
                                    .toString() +
                                ", " +
                                Provider.of<SubscriptionProvider>(context,
                                        listen: false)
                                    .request
                                    .contact
                                    .address
                                    .postalCode +
                                " " +
                                Provider.of<SubscriptionProvider>(context,
                                        listen: false)
                                    .request
                                    .contact
                                    .address
                                    .city),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: rowTwoTexts(
                            firstText: 'summary.rent',
                            secondText: Provider.of<SubscriptionProvider>(
                                        context,
                                        listen: false)
                                    .request
                                    .property
                                    .rent
                                    .toStringAsFixed(2)
                                    .replaceAll(".", ",") +
                                " €/" +
                                allTranslations.text("common.month")),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget rowTwoTexts({String firstText, String secondText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: P(
            allTranslations.text(firstText),
            color: KitUIColors.NEUTRAL_50,
            textAlign: TextAlign.left,
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 160,
            child: P(
              secondText,
              color: KitUIColors.NEUTRAL_100,
              textAlign: TextAlign.right,
            ),
          ),
        )
      ],
    );
  }
}
