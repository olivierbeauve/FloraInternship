import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/account-summary-dto.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/service/authentication-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-3/credit-card-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../subscription-fourth-step-view.dart';
import 'moving-date-contract-view.dart';

class PaymentMethodView extends StatefulWidget {
  static const String ROUTE_NAME = '/payment_method_contract';
  static const int INDEX = 3;

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethodView> {
  bool creditCardState;
  bool isSelected = false;
  AccountService accountService = AccountService();
  AuthenticationService authenticationService = AuthenticationService();
  bool loading = false;

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
                          allTranslations
                              .text('subscription_step.payment.title'),
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
                              .text('subscription_step.payment.sub_title'),
                          color: KitUIColors.NEUTRAL_70,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  containerWithIconAndText(
                      icon: SvgIcons.ZERO,
                      firstText: 'subscription_step.payment.credit_card',
                      creditCard: true),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  containerWithIconAndText(
                      icon: SvgIcons.ONE_PLUS,
                      firstText: 'subscription_step.payment.domiciliation',
                      creditCard: false),
                ],
              ),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  isLoading: loading,
                  onPressedNext: () => {
                    creditCardState
                        ? Provider.of<SubscriptionProvider>(context,
                                listen: false)
                            .setIndexSubscription(CreditCardView.INDEX)
                        : goToConfirmationPage()
                  },
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexSubscription(MovingDateContractView.INDEX),
                  isDisable: loading ? loading : !isSelected,
                )),
          ],
        ),
      ),
    );
  }

  Widget containerWithIconAndText(
      {String icon, String firstText, bool creditCard}) {
    return Align(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            creditCardState = creditCard;
            isSelected = true;
          });
          Provider.of<SubscriptionProvider>(context, listen: false).creditCard =
              creditCard;
          await Future.delayed(const Duration(milliseconds: 200), () {});
          if (creditCard)
            Provider.of<SubscriptionProvider>(context, listen: false)
                .setIndexSubscription(CreditCardView.INDEX);
          else
            goToConfirmationPage();
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
                    creditCardState != null && creditCardState == creditCard
                        ? FontWeightEnum.Bold
                        : FontWeightEnum.Medium,
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: creditCardState != null && creditCardState == creditCard
                  ? KitUIColors.PRIMARY_05
                  : KitUIColors.WHITE,
              border: Border.all(
                  color:
                      creditCardState != null && creditCardState == creditCard
                          ? KitUIColors.PRIMARY_50
                          : KitUIColors.NEUTRAL_20,
                  width: 1),
              borderRadius: new BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }

  void goToConfirmationPage() async {
    setState(() {
      loading = true;
    });
    AccountSummaryDTO summary = await accountService.getAccount();
    String correlationId = summary.onlineSubscriptions.first.subscriptionId;

    String startDate = Provider.of<SubscriptionProvider>(context, listen: false)
        .request
        .policy
        .startDate;

    Map<String, dynamic> response = await accountService
        .getMyQuote(startDate, correlationId, isPublic: true);

    if (response != null) {
      ConfirmSubscription confirmSubscription = ConfirmSubscription();
      confirmSubscription.accountSummary = summary;
      confirmSubscription.quote = response;
      Navigator.pushNamed(context, SubscriptionFourthStepView.ROUTE_NAME,
          arguments: confirmSubscription);
    } else {
      Toast.show(
          allTranslations.text("common.error_page.client_error"), context);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    creditCardState =
        Provider.of<SubscriptionProvider>(context, listen: false).creditCard;
    isSelected = (creditCardState != null);
  }
}
