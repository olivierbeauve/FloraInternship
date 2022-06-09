import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/pricing-response.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-1/rent-price-view.dart';
import 'package:flora/subscription/subscription-second-step-view.dart';
import 'package:flora/subscription/widget/advantages-flora.dart';
import 'package:flora/subscription/widget/content-contract.dart';
import 'package:flora/subscription/widget/housing-info.dart';
import 'package:flora/subscription/widget/option-container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

enum OptionType { Vol, Responsability }

class QuoteView extends StatefulWidget {
  static const String ROUTE_NAME = '/quote';
  static const int INDEX = 4;

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<QuoteView> {
  bool theftIsSelected;
  bool responsabilityIsSelected = false;
  bool isChecked = false;
  PricingResponse pricingResponse;

  Widget build(context) {
    pricingResponse = Provider.of<SubscriptionProvider>(context, listen: false)
        .pricingResponse;
    return BaseView(
      body: Container(
        child: ListView(padding: EdgeInsets.zero, children: [
          StickyHeader(
              header: Column(
                children: [
                  Container(
                    height: 121,
                    color: KitUIColors.PRIMARY_05,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Container(
                                  child: Text(
                                      computeTotalPriceMonth()
                                          .toString()
                                          .split('.')[0],
                                      style: TextStyle(
                                        height: 80 / 80,
                                        fontSize: 80,
                                        color: KitUIColors.PRIMARY_50,
                                        fontWeight: FontWeight.w400,
                                      )),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 28.0, left: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "," +
                                          computeTotalPriceMonth()
                                              .toString()
                                              .split('.')[1] +
                                          "€",
                                      style: TextStyle(
                                        height: 40 / 32,
                                        fontSize: 32,
                                        color: KitUIColors.PRIMARY_50,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Small(
                                    "/ " + allTranslations.text("common.month"),
                                    color: KitUIColors.NEUTRAL_70,
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: XSmall(
                                      allTranslations.text("summary.bref") +
                                          " " +
                                          computeTotalPriceYear()
                                              .toStringAsFixed(2)
                                              .replaceAll(".", ",") +
                                          "€ / " +
                                          allTranslations.text("common.year"),
                                      color: KitUIColors.NEUTRAL_50,
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      height: 88,
                      width: MediaQuery.of(context).size.width,
                      color: KitUIColors.PRIMARY_05,
                      child: Column(
                        children: [
                          XSmall(
                            allTranslations.text("summary.pricing_msg_1"),
                            color: KitUIColors.NEUTRAL_50,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: XSmall(
                              allTranslations.text("summary.pricing_msg_2"),
                              color: KitUIColors.NEUTRAL_70,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: H4(
                              allTranslations.text('summary.coverages_header'),
                              color: KitUIColors.NEUTRAL_100,
                              fontWeight: FontWeightEnum.Bold,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: Row(
                              children: [
                                H5(
                                  allTranslations.text('summary.housing_title'),
                                  color: KitUIColors.NEUTRAL_100,
                                  fontWeight: FontWeightEnum.Bold,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: KitUIColors.WHITE,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(16)),
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
                              child: HousingInfo())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: Row(
                              children: [
                                H5(
                                  allTranslations
                                      .text('summary.content_contract'),
                                  color: KitUIColors.NEUTRAL_100,
                                  fontWeight: FontWeightEnum.Bold,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ContentContract()),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: Row(
                              children: [
                                H5(
                                  allTranslations
                                      .text('summary.option_advised'),
                                  color: KitUIColors.NEUTRAL_100,
                                  fontWeight: FontWeightEnum.Bold,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: OptionContainer(
                            optionTitle: 'options.container_first.option_title',
                            description: 'options.container_first.description',
                            priceMonth: pricingResponse.options[0].price,
                            optionType: OptionType.Vol,
                            pricingResponse: pricingResponse,
                            switchButton: switchButton(OptionType.Vol),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: Row(
                              children: [
                                H5(
                                  allTranslations.text('summary.advantages'),
                                  color: KitUIColors.NEUTRAL_100,
                                  fontWeight: FontWeightEnum.Bold,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: AdvantagesFlora()),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: H5(
                              allTranslations
                                  .text('summary.not_assured_question'),
                              color: KitUIColors.NEUTRAL_100,
                              fontWeight: FontWeightEnum.Bold,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: P(
                              allTranslations.text('summary.no_problem'),
                              color: KitUIColors.NEUTRAL_100,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    checkColor: KitUIColors.WHITE,
                                    activeColor: KitUIColors.PRIMARY_50,
                                    side: BorderSide(
                                        color: KitUIColors.NEUTRAL_20,
                                        width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.4))),
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 8)),
                                Container(
                                  width: 326,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      P(
                                        allTranslations
                                            .text('summary.declaration_part1'),
                                        color: KitUIColors.NEUTRAL_100,
                                        textAlign: TextAlign.left,
                                      ),
                                      GestureDetector(
                                        onTap: getConditions,
                                        child: Text(
                                          allTranslations.text(
                                              "summary.declaration_part2"),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 24 / 16,
                                              color: KitUIColors.NEUTRAL_100,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      P(
                                        allTranslations
                                            .text('summary.declaration_part3'),
                                        color: KitUIColors.NEUTRAL_100,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 32),
                      child: Column(
                        children: [
                          Container(
                            width: 358,
                            height: 48,
                            child: BtnPrimaryBase(
                                isDisable: !isChecked,
                                text: allTranslations
                                    .text("summary.take_insurance"),
                                onPressed: handlePressedConfirm),
                          ),
                          Container(
                            width: 358,
                            height: 48,
                            child: BtnTertiaryBase(
                              text: allTranslations.text("type_home.previous"),
                              onTap: () => Provider.of<SubscriptionProvider>(
                                      context,
                                      listen: false)
                                  .setIndexQuote(RentPriceView.INDEX),
                              color: KitUIColors.NEUTRAL_50,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  double computeTotalPriceMonth() {
    if (theftIsSelected)
      return pricingResponse.pricing.price + pricingResponse.options[0].price;
    else
      return pricingResponse.pricing.price;
  }

  double computeTotalPriceYear() {
    if (theftIsSelected)
      return pricingResponse.pricing.price * 12 +
          pricingResponse.options[0].price * 12;
    else
      return pricingResponse.pricing.price * 12;
  }

  getConditions() async {
    const url =
        'https://flora.insure/wp-content/uploads/2020/09/Assurance-incendie-locataire-Flora-Insurance-conditions-generales-fr.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void handlePressedConfirm() {
    if (Provider.of<SubscriptionProvider>(context, listen: false)
        .request
        .policy
        .options
        .contains("TheftAndVandalism")) {
      if (!theftIsSelected) {
        Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .policy
            .options
            .remove("TheftAndVandalism");
      }
    } else {
      if (theftIsSelected) {
        Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .policy
            .options
            .add("TheftAndVandalism");
      }
    }

    Navigator.of(context).pushNamed(SubscriptionSecondStepView.ROUTE_NAME);
  }

  void initState() {
    super.initState();
    if (Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .policy
            .options ==
        null) {
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .policy
          .options = [];
    }
    if (Provider.of<SubscriptionProvider>(context, listen: false)
        .request
        .policy
        .options
        .contains("TheftAndVandalism")) {
      theftIsSelected = true;
    } else
      theftIsSelected = false;
  }

  Widget switchButton(OptionType optionType) {
    return Switch(
      value: optionType == OptionType.Vol
          ? theftIsSelected
          : responsabilityIsSelected,
      onChanged: (value) {
        setState(() {
          if (optionType == OptionType.Vol)
            theftIsSelected = !theftIsSelected;
          else
            responsabilityIsSelected = !responsabilityIsSelected;
        });
      },
      activeTrackColor: KitUIColors.PRIMARY_20,
      activeColor: KitUIColors.PRIMARY_50,
      inactiveThumbColor: KitUIColors.WHITE,
      inactiveTrackColor: KitUIColors.NEUTRAL_20,
    );
  }
}
