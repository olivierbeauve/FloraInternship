import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/confirm-subscription-request.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/service/authentication-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/document/contract/termination/termination-request.dart';
import 'package:flora/landing/landing-view.dart';
import 'package:flora/payment/switch-dto.dart';
import 'package:flora/subscription/step-3/credit-card-view.dart';
import 'package:flora/subscription/step-4/info-go-card-less-view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ConfirmationSubscriptionView extends StatefulWidget {
  static const String ROUTE_NAME = '/confirmation-subscription';
  static const int INDEX = 0;

  @override
  _ConfirmationSubscriptionState createState() =>
      _ConfirmationSubscriptionState();
}

class _ConfirmationSubscriptionState
    extends State<ConfirmationSubscriptionView> {
  bool isLoading = false;
  ConfirmSubscription arguments;
  String startDate;
  String endDate;
  final AccountService accountService = AccountService();
  AuthenticationService authenticationService = AuthenticationService();

  Widget build(context) {
    arguments = ModalRoute.of(context).settings.arguments;
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
                  child: H4(
                    allTranslations
                        .text('subscription_step.confirmation.title'),
                    color: KitUIColors.NEUTRAL_100,
                    fontWeight: FontWeightEnum.Bold,
                    textAlign: TextAlign.left,
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
                          child: housingInfoConfirmation())
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
                              allTranslations.text(
                                  'subscription_step.confirmation.who_to_assure_title'),
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
                          child: containerWithTitleAndText(
                              title: arguments.accountSummary.firstName +
                                  " " +
                                  arguments.accountSummary.lastName,
                              text: "#29/05/1999"))
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
                              allTranslations.text(
                                  'subscription_step.confirmation.duration'),
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
                          child: containerWithTitleAndText(
                              title: allTranslations.text(
                                  "subscription_step.confirmation.period_title",
                                  options: {
                                    'fromDate':
                                        Provider.of<SubscriptionProvider>(
                                                context,
                                                listen: false)
                                            .request
                                            .policy
                                            .startDate,
                                    'endDate': endDate
                                  }),
                              text: allTranslations.text(
                                  "subscription_step.confirmation.period_text")))
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
                                  .text('subscription_step.confirmation.price'),
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
                          child: priceSummary())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                          width: 358,
                          child: Small(
                            allTranslations.text(
                                'subscription_step.confirmation.text_abex'),
                            color: KitUIColors.NEUTRAL_100,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      Container(
                          width: 358,
                          child: H5(
                            allTranslations
                                .text('subscription_step.confirmation.payment'),
                            fontWeight: FontWeightEnum.Bold,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      !Provider.of<SubscriptionProvider>(context, listen: false)
                              .creditCard
                          ? Container(
                              width: 358,
                              child: P(allTranslations.text(
                                      'subscription_step.confirmation.payment') +
                                  " " +
                                  allTranslations.text(
                                      'subscription_step.confirmation.mensuel') +
                                  " / " +
                                  allTranslations.text(
                                      'subscription_step.confirmation.domiciliation')))
                          : Container(
                              width: 358,
                              child: P(allTranslations.text(
                                      'subscription_step.confirmation.payment') +
                                  " " +
                                  allTranslations.text(
                                      'subscription_step.confirmation.mensuel') +
                                  " / " +
                                  allTranslations.text(
                                      'subscription_step.confirmation.credit_card')))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                          width: 358,
                          child: Small(
                            allTranslations.text(
                                "document.contract.move.subscription.long_text"),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                          width: 358,
                          child: Small(
                            allTranslations
                                .text('subscription_step.confirmation.agree'),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                          width: 358,
                          child: Small(
                            allTranslations
                                .text('subscription_step.confirmation.know'),
                          ))
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
                            isDisable: isLoading,
                            isLoading: isLoading,
                            text: allTranslations
                                .text('subscription_step.confirmation.confirm'),
                            onPressed: handlePressedConfirm),
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
              ])
            ])),
          ],
        ),
      ),
    );
  }

  double computeInsurancePriceMonth() {
    double priceMonth = arguments.quote["pricing"]["price"];
    return priceMonth;
  }

  double computeInsurancePriceYear() {
    double priceMonth = arguments.quote["pricing"]["price"];
    return priceMonth * 12;
  }

  double computePriceOptionMonth() {
    if (arguments.quote["options"].length > 0) {
      double priceOptionMonth = arguments.quote["options"][0]["price"];
      return priceOptionMonth;
    }
    return 0;
  }

  double computePriceOptionYear() {
    if (arguments.quote["options"].length > 0) {
      double priceOptionMonth = arguments.quote["options"][0]["price"];
      return priceOptionMonth * 12;
    }
    return 0;
  }

  Widget containerWithTitleAndText({String title, String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Row(
            children: [
              Container(
                width: 294,
                child: P(
                  title,
                  fontWeight: FontWeightEnum.Bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4, bottom: 16),
          child: Row(
            children: [
              Container(
                width: 294,
                child: Small(
                  text,
                  color: KitUIColors.NEUTRAL_50,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void handlePressedConfirm() async {
    setState(() {
      isLoading = true;
    });
    bool isCard =
        Provider.of<SubscriptionProvider>(context, listen: false).creditCard;
    if (isCard) {
      ConfirmSubscriptionRequest request = ConfirmSubscriptionRequest();
      request.partyId = await authenticationService.provider.getUserId();
      request.quoteId = arguments.quote["quoteId"];
      request.startDate = startDate;
      request.productType = "PropertyRenter";
      request.paymentSystem = "Stripe";
      request.paymentSystemProps = PaymentSystemProps();
      request.paymentSystemProps.paymentMethod =
          Provider.of<SubscriptionProvider>(context, listen: false)
              .paymentMethodId;
      bool response = await accountService.confirmSubscription(request);
      if (response) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            LandingView.ROUTE_NAME, (Route<dynamic> route) => false);
      } else {
        Toast.show(
            allTranslations.text("common.error_page.client_error"), context);
      }
    } else {
      Provider.of<SubscriptionProvider>(context, listen: false)
          .setIndexConfirmation(InfoGoCardLessView.INDEX);
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget housingInfoConfirmation() {
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
                          secondText: arguments.accountSummary.property.type
                              .toTranslatedString()),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: rowTwoTexts(
                            firstText: 'summary.address',
                            secondText: arguments
                                    .accountSummary.address.streetName +
                                " " +
                                arguments.accountSummary.address.streetNumber +
                                ", " +
                                arguments.accountSummary.address.postalCode +
                                " " +
                                arguments.accountSummary.address.city),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: rowTwoTexts(
                            firstText: 'summary.rent',
                            secondText: arguments.accountSummary.property.rent
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

  void initState() {
    super.initState();
    startDate = Provider.of<SubscriptionProvider>(context, listen: false)
        .request
        .policy
        .startDate;
    var startDateSplitted = startDate.split("/");

    DateTime endDateTmp = DateTime.parse(
        startDateSplitted[2] + startDateSplitted[1] + startDateSplitted[0]);
    endDateTmp =
        DateTime(endDateTmp.year + 1, endDateTmp.month, endDateTmp.day - 1, 0);
    endDate = DateFormat("dd/MM/yyyy").format(endDateTmp).toString();
  }

  Widget priceSummary() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            children: [
              Expanded(
                child: P(
                  allTranslations
                      .text("coverages.add_coverage_confirm.renter_insurance"),
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: P(
                  computeInsurancePriceYear()
                          .toStringAsFixed(2)
                          .replaceAll(".", ",") +
                      " €",
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 16),
          child: Row(
            children: [
              Expanded(
                child: Small(
                  allTranslations
                      .text("coverages.add_coverage_confirm.renter_text"),
                  color: KitUIColors.NEUTRAL_50,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Small(
                  allTranslations
                      .text("subscription_step.confirmation.per_year"),
                  color: KitUIColors.NEUTRAL_50,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        arguments.quote["options"].length > 0
            ? Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: P(
                        allTranslations
                            .text("document.contract.detail.warranties.option"),
                        color: KitUIColors.NEUTRAL_100,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: P(
                        computePriceOptionYear()
                                .toStringAsFixed(2)
                                .replaceAll(".", ",") +
                            " €",
                        color: KitUIColors.NEUTRAL_100,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              )
            : Container(),
        arguments.quote["options"].length > 0
            ? Padding(
                padding: const EdgeInsets.only(top: 4, left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Small(
                        allTranslations
                            .text("options.container_first.option_title"),
                        color: KitUIColors.NEUTRAL_50,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Small(
                        allTranslations
                            .text("subscription_step.confirmation.per_year"),
                        color: KitUIColors.NEUTRAL_50,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              )
            : Container(),
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
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            children: [
              Expanded(
                child: P(
                  allTranslations
                      .text('subscription_step.confirmation.total_year'),
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeightEnum.Bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: P(
                  (computePriceOptionYear() + computeInsurancePriceYear())
                          .toStringAsFixed(2)
                          .replaceAll(".", ",") +
                      " €",
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.right,
                  fontWeight: FontWeightEnum.Bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Small(
                  allTranslations
                      .text("subscription_step.confirmation.per_year"),
                  color: KitUIColors.NEUTRAL_50,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            children: [
              Expanded(
                child: P(
                  "Soit",
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeightEnum.Bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: P(
                  (computePriceOptionMonth() + computeInsurancePriceMonth())
                          .toStringAsFixed(2)
                          .replaceAll(".", ",") +
                      " €",
                  color: KitUIColors.NEUTRAL_100,
                  textAlign: TextAlign.right,
                  fontWeight: FontWeightEnum.Bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Small(
                  allTranslations
                      .text("subscription_step.confirmation.per_month"),
                  color: KitUIColors.NEUTRAL_50,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
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
