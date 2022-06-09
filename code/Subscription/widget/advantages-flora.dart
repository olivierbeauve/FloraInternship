import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';

class AdvantagesFlora extends StatelessWidget {
  Widget advantage({String firstText, String secondText}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Container(
                  height: 24,
                  width: 24,
                  child: CircleAvatar(
                    backgroundColor: KitUIColors.YELLOW,
                    child: SvgIcons.CHECK.toIcon(height: 16),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: P(
                  allTranslations.text(firstText),
                  color: KitUIColors.NEUTRAL_100,
                  fontWeight: FontWeightEnum.Bold,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16),
          child: Row(
            children: [
              Container(
                  width: 254,
                  child: Small(
                    allTranslations.text(secondText),
                    color: KitUIColors.NEUTRAL_70,
                    textAlign: TextAlign.left,
                  ))
            ],
          ),
        )
      ],
    );
  }

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
                blurRadius: 8,
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
                      advantage(
                          firstText: 'summary.first_advantage_title',
                          secondText: 'summary.first_advantage_description'),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: advantage(
                            firstText: 'summary.second_advantage_title',
                            secondText: 'summary.second_advantage_description'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: advantage(
                            firstText: 'summary.third_advantage_title',
                            secondText: 'summary.third_advantage_description'),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}
