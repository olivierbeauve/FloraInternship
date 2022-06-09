import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/generic-view.dart';
import 'package:flora/subscription/step-4/confirmation-subscription-view.dart';
import 'package:flora/subscription/step-4/info-go-card-less-view.dart';
import 'package:flora/subscription/widget/circle-steps.dart';
import 'package:flora/subscription/widget/header-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionFourthStepView extends StatefulWidget {
  static const String ROUTE_NAME = '/subscription-fourth-step';

  @override
  _SubscriptionFourthStepState createState() => _SubscriptionFourthStepState();
}

class _SubscriptionFourthStepState extends State<SubscriptionFourthStepView> {
  final Map<int, Widget> views = {
    ConfirmationSubscriptionView.INDEX: ConfirmationSubscriptionView(),
    InfoGoCardLessView.INDEX: InfoGoCardLessView()
  };

  @override
  Widget build(BuildContext context) {
    return GenericView(
        header: HeaderGenericWidget(
            isFixed: true,
            title: allTranslations
                .text("subscription_step.confirmation.title_header"),
            bottomLeft: HeaderComponent(
                width: 44,
                height: 44,
                icon: CustomPaint(
                  painter: CircleSteps(step: 4),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 22,
                      child: Small(
                        "4/4",
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
              return views[provider.currentPageConfirmation];
            },
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexConfirmation(ConfirmationSubscriptionView.INDEX,
            notify: false);
  }
}
