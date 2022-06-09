import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/generic-view.dart';
import 'package:flora/subscription/step-2/create-account-view.dart';
import 'package:flora/subscription/step-2/login-subscription-view.dart';
import 'package:flora/subscription/step-2/resent-email-view.dart';
import 'package:flora/subscription/step-2/reset-password-subscription-view.dart';
import 'package:flora/subscription/widget/circle-steps.dart';
import 'package:flora/subscription/widget/header-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionSecondStepView extends StatefulWidget {
  static const String ROUTE_NAME = '/subscription-second-step';

  @override
  _SubscriptionSecondStepState createState() => _SubscriptionSecondStepState();
}

class _SubscriptionSecondStepState extends State<SubscriptionSecondStepView> {
  final Map<int, Widget> views = {
    CreateAccountView.INDEX: CreateAccountView(),
    ResentEmailView.INDEX: ResentEmailView(),
    LoginSubscriptionView.INDEX: LoginSubscriptionView(),
    ResetPasswordSubscriptionView.INDEX: ResetPasswordSubscriptionView()
  };

  @override
  Widget build(BuildContext context) {
    return GenericView(
      header: HeaderGenericWidget(
          isFixed: true,
          title: allTranslations.text("account_creation.title"),
          bottomLeft: HeaderComponent(
              width: 44,
              height: 44,
              icon: CustomPaint(
                painter: CircleSteps(step: 2),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 22,
                    child: Small(
                      "2/4",
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
          child: content()),
    );
  }

  Widget content() {
    return Container(
        height: MediaQuery.of(context).size.height - 152,
        child:
            Consumer<SubscriptionProvider>(builder: (context, provider, child) {
          return PageView.builder(
            itemBuilder: (context, index) {
              return views[provider.currentPageCreateAccount];
            },
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexAccount(CreateAccountView.INDEX, notify: false);
  }
}
