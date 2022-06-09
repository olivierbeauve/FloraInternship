import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/pricing-response.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/step-1/quote-view.dart';
import 'package:flora/subscription/widget/header-small-modal.dart';
import 'package:flora/subscription/widget/small-modal.dart';
import 'package:flutter/material.dart';

class OptionContainer extends StatefulWidget {
  final String optionTitle;
  final String description;
  final double priceMonth;
  final OptionType optionType;
  final Widget switchButton;
  final PricingResponse pricingResponse;

  OptionContainer(
      {this.optionTitle,
      this.description,
      this.priceMonth,
      this.optionType,
      this.pricingResponse,
      this.switchButton});

  @override
  _OptionContainerState createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer> {
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          child: SvgIcons.THEFT
                              .toIcon(color: KitUIColors.PRIMARY_50),
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: P(
                                allTranslations.text(widget.optionTitle),
                                color: KitUIColors.NEUTRAL_100,
                                fontWeight: FontWeightEnum.Bold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            widget.optionType == OptionType.Vol
                                ? XSmall(
                                    allTranslations.text(
                                            "options.container_first.until") +
                                        widget
                                            .pricingResponse.pricing.maxCoverage
                                            .toStringAsFixed(2)
                                            .replaceAll(".", ",") +
                                        "€",
                                    color: KitUIColors.NEUTRAL_50,
                                    textAlign: TextAlign.left,
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Small(
                        "+ " +
                            widget.priceMonth
                                .toStringAsFixed(2)
                                .replaceAll(".", ",") +
                            " € /" +
                            allTranslations.text("common.month"),
                        color: KitUIColors.NEUTRAL_70,
                        textAlign: TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: XSmall(
                          (widget.priceMonth * 12)
                                  .toStringAsFixed(2)
                                  .replaceAll(".", ",") +
                              " € /" +
                              allTranslations.text("common.year"),
                          color: KitUIColors.NEUTRAL_50,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Small(
                        allTranslations.text(widget.description),
                        color: KitUIColors.NEUTRAL_70,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                          height: 19.2, width: 34, child: widget.switchButton),
                    )
                  ],
                ),
              ),
            ),
          ),
          widget.pricingResponse.risk > 1
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 16,
                            width: 16,
                            child: SvgIcons.ATTENTION.toIcon(
                                height: 12, color: KitUIColors.WARNING_50),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            XSmall(
                              allTranslations.text("summary.title_risk_zone"),
                              fontWeight: FontWeightEnum.Bold,
                              color: KitUIColors.WARNING_50,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 326,
                              child: XSmall(
                                allTranslations
                                    .text("summary.content_risk_zone"),
                                color: KitUIColors.NEUTRAL_70,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => SmallModal.smallModal(
                                  context,
                                  HeaderSmallModal(
                                      text: allTranslations
                                          .text('summary.more_theft_header')),
                                  moreAboutTheftModalContent(context)),
                              child: Small(
                                allTranslations
                                    .text('options.container_first.more'),
                                color: KitUIColors.PRIMARY_50,
                                fontWeight: FontWeightEnum.Bold,
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(padding: EdgeInsets.only(bottom: 16))
        ],
      ),
    );
  }

  Widget moreAboutTheftModalContent(context) {
    return Container(
        height: 423,
        width: MediaQuery.of(context).size.width,
        color: KitUIColors.NEUTRAL_05,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: SvgIcons.BELGIUM3.toIcon(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: H4(
                      allTranslations.text("summary.more_theft_title"),
                      fontWeight: FontWeightEnum.Bold,
                      color: KitUIColors.NEUTRAL_100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 358,
                      child: P(
                        allTranslations.text("summary.more_theft_content"),
                        color: KitUIColors.NEUTRAL_100,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Container(
                width: 358,
                height: 48,
                child: BtnPrimaryBase(
                    text: allTranslations.text("address.understood"),
                    onPressed: () => Navigator.pop(context)),
              ),
            ),
          ],
        ));
  }
}
