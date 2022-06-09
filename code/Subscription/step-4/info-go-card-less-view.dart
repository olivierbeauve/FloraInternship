import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/create-mandate-go-card-less-request.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/service/authentication-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-4/confirmation-subscription-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoGoCardLessView extends StatefulWidget {
  static const String ROUTE_NAME = '/info-go-card-less';
  static const int INDEX = 1;

  @override
  _InfoGoCardLessState createState() => _InfoGoCardLessState();
}

class _InfoGoCardLessState extends State<InfoGoCardLessView> {
  AuthenticationService authenticationService = AuthenticationService();
  AccountService accountService = AccountService();
  Widget build(context) {
    return BaseView(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
                Column(children: [
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    width: 358,
                    child: P(
                      allTranslations
                          .text('subscription_step.go_card_less.description1'),
                      color: KitUIColors.NEUTRAL_70,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    width: 358,
                    child: P(
                      allTranslations
                          .text('subscription_step.go_card_less.description2'),
                      color: KitUIColors.NEUTRAL_70,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    width: 358,
                    child: P(
                      allTranslations
                          .text('subscription_step.go_card_less.description3'),
                      color: KitUIColors.NEUTRAL_70,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ])
              ]),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: handlePressedConfirm,
                  onPressedPrevious: () => Provider.of<SubscriptionProvider>(
                          context,
                          listen: false)
                      .setIndexConfirmation(ConfirmationSubscriptionView.INDEX),
                )),
          ],
        ),
      ),
    );
  }

  void handlePressedConfirm() async {
    MandateGoCardLess request = MandateGoCardLess();
    request.partyId = await authenticationService.provider.getUserId();
    request.redirectUrl =
        "https://subscribe.dev.flora.insure/register/payment/domiciliation/mandate-creation-pending";
    await accountService.createMandate(request);
  }

  @override
  void initState() {
    super.initState();
  }
}
