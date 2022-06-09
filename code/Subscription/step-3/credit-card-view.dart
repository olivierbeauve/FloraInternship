import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/account-summary-dto.dart';
import 'package:flora/@common/dto/validate-payment-method-request.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/service/authentication-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/stripe/stripe-service.dart';
import 'package:flora/subscription/step-3/payment-method-view.dart';
import 'package:flora/subscription/subscription-fourth-step-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/credit-card-field.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:stripe_platform_interface/stripe_platform_interface.dart';
import 'package:toast/toast.dart';

class ConfirmSubscription {
  AccountSummaryDTO accountSummary;
  Map<String, dynamic> quote;
}

class CreditCardView extends StatefulWidget {
  static const String ROUTE_NAME = "/credit-card";
  static const int INDEX = 4;
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCardView> {
  bool isLoading = false;
  CardFieldInputDetails curCard;
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();
  AccountService accountService = AccountService();
  AuthenticationService authenticationService = AuthenticationService();

  String errorText;
  @override
  Widget build(BuildContext context) {
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
                            .text('subscription_step.credit_card.title'),
                        color: KitUIColors.NEUTRAL_100,
                        fontWeight: FontWeightEnum.Bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: 358,
                      child: FormBuilder(
                        key: _formBuilderKey,
                        child: FormBuilderField(
                          name: "credit_card",
                          builder: ((formBuilderState) {
                            return CreditCardField(
                              label:
                                  allTranslations.text('payment_method.title'),
                              width: 358,
                              errorText: errorText,
                              onCardChanged: (card) {
                                setState(() {
                                  curCard = card;
                                });
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ChatOpening(),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 32),
            child: PreviousNextButtons(
              onPressedNext: curCard?.complete == true
                  ? () {
                      setState(() {
                        errorText = null;
                      });
                      handlePayPress();
                    }
                  : () {
                      setState(() {
                        errorText = "* " +
                            allTranslations
                                .text("common.form.validation.field.required");
                      });
                    },
              onPressedPrevious: () =>
                  Provider.of<SubscriptionProvider>(context, listen: false)
                      .setIndexSubscription(PaymentMethodView.INDEX),
              isLoading: isLoading,
              isDisable: isLoading,
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> handlePayPress() async {
    setState(() {
      isLoading = true;
    });
    if (curCard == null) {
      return;
    }
    try {
      final clientSecret = await StripeService().getSetupIntentId();
      final setupIntentResult = await Stripe.instance.confirmSetupIntent(
        clientSecret,
        PaymentMethodParams.card(),
      );

      if (setupIntentResult.status == 'Succeeded') {
        errorText = null;
        String cognitoId = await authenticationService.provider.getUserId();
        AccountSummaryDTO summary = await accountService.getAccount();
        String correlationId = summary.onlineSubscriptions.first.subscriptionId;

        Provider.of<SubscriptionProvider>(context, listen: false)
            .paymentMethodId = setupIntentResult.paymentMethodId;
        String startDate =
            Provider.of<SubscriptionProvider>(context, listen: false)
                .request
                .policy
                .startDate;
        Map<String, dynamic> response = await accountService
            .getMyQuote(startDate, correlationId, isPublic: true);

        if (response != null) {
          ValidatePaymentMethodRequest validatePaymentMethodRequest =
              ValidatePaymentMethodRequest();
          validatePaymentMethodRequest.partyId = cognitoId;
          validatePaymentMethodRequest.paymentMethod =
              setupIntentResult.paymentMethodId;
          validatePaymentMethodRequest.paymentSystem = "Stripe";
          validatePaymentMethodRequest.quoteId = response["quoteId"];
          bool responseValidatePayment = await accountService
              .validatePayment(validatePaymentMethodRequest);
          if (responseValidatePayment) {
            ConfirmSubscription confirmSubscription = ConfirmSubscription();
            confirmSubscription.accountSummary = summary;
            confirmSubscription.quote = response;
            Navigator.pushNamed(context, SubscriptionFourthStepView.ROUTE_NAME,
                arguments: confirmSubscription);
          } else {
            Toast.show(allTranslations.text("common.error_page.client_error"),
                context);
          }
        } else {
          Toast.show(
              allTranslations.text("common.error_page.client_error"), context);
        }
      }
    } catch (error) {
      if (error.toString().contains("insufficient_funds")) {
        errorText = "* " +
            allTranslations
                .text("profile.payment.change.error_insufficient.text");
      } else if (errorText.toString().contains("expired_card")) {
        errorText =
            "* " + allTranslations.text("payment_method.card_expire_error");
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
