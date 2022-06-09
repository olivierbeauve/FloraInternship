import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/generic-view.dart';
import 'package:flora/subscription/step-3/already-assured-view.dart';
import 'package:flora/subscription/step-3/credit-card-view.dart';
import 'package:flora/subscription/step-3/info-before-subscription-view.dart';
import 'package:flora/subscription/step-3/info-terminate-contract-view.dart';
import 'package:flora/subscription/step-3/moving-date-contract-view.dart';
import 'package:flora/subscription/step-3/payment-method-view.dart';
import 'package:flora/subscription/widget/circle-steps.dart';
import 'package:flora/subscription/widget/header-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionThirdStepView extends StatefulWidget {
  static const String ROUTE_NAME = '/subscription-third-step';

  @override
  _SubscriptionThirdStepState createState() => _SubscriptionThirdStepState();
}

class _SubscriptionThirdStepState extends State<SubscriptionThirdStepView> {
  final Map<int, Widget> views = {
    InfoBeforeSubscriptionView.INDEX: InfoBeforeSubscriptionView(),
    AlreadyAssuredView.INDEX: AlreadyAssuredView(),
    MovingDateContractView.INDEX: MovingDateContractView(),
    PaymentMethodView.INDEX: PaymentMethodView(),
    CreditCardView.INDEX: CreditCardView(),
    InfoTerminateContractView.INDEX: InfoTerminateContractView()
  };

  @override
  Widget build(BuildContext context) {
    return GenericView(
        header: HeaderGenericWidget(
            isFixed: true,
            title: allTranslations.text("subscription_step.title"),
            bottomLeft: HeaderComponent(
                width: 44,
                height: 44,
                icon: CustomPaint(
                  painter: CircleSteps(step: 3),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 22,
                      child: Small(
                        "3/4",
                        fontWeight: FontWeightEnum.Semibold,
                        color: KitUIColors.NEUTRAL_70,
                      )),
                )),
            topRight: HeaderComponent(
                icon: SvgIcons.CROSS.toIcon(color: KitUIColors.PRIMARY_50),
                onPressed: () {
                  Navigator.pop(context);
                })),
        content: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: content()));
  }

  Widget content() {
    return Container(
        height: MediaQuery.of(context).size.height - 152,
        child:
            Consumer<SubscriptionProvider>(builder: (context, provider, child) {
          return PageView.builder(
            itemBuilder: (context, index) {
              return views[provider.currentPageSubscription];
            },
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexSubscription(InfoBeforeSubscriptionView.INDEX, notify: false);
  }
}
