import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';

class ContentContract extends StatelessWidget {
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
                      rowWithIconAndText(
                          firstText: allTranslations
                              .text('summary.first_content_title'),
                          secondText: allTranslations
                              .text('summary.first_content_description'),
                          icon: SvgIcons.HOUSE),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Container(
                              color: KitUIColors.WHITE,
                              child: Container(
                                height: 1,
                                width: 16,
                              ),
                            ),
                            Container(
                              color: KitUIColors.NEUTRAL_20,
                              child: Container(
                                height: 1,
                                width: 342,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: rowWithIconAndText(
                            firstText: allTranslations
                                .text('summary.second_content_title'),
                            secondText: allTranslations
                                .text('summary.second_content_description'),
                            icon: SvgIcons.PHONE),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget rowWithIconAndText(
      {String firstText, String secondText, String icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            width: 24,
            height: 24,
            child: icon.toIcon(color: KitUIColors.PRIMARY_50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              P(
                firstText,
                color: KitUIColors.NEUTRAL_100,
                fontWeight: FontWeightEnum.Bold,
                textAlign: TextAlign.left,
              ),
              Container(
                width: 254,
                child: Small(
                  secondText,
                  color: KitUIColors.NEUTRAL_50,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
