import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/generic-view.dart';
import 'package:flora/subscription/step-1/address-view.dart';
import 'package:flora/subscription/step-1/floor-view.dart';
import 'package:flora/subscription/step-1/housing-type-view.dart';
import 'package:flora/subscription/step-1/quote-view.dart';
import 'package:flora/subscription/step-1/rent-price-view.dart';
import 'package:flora/subscription/widget/circle-steps.dart';
import 'package:flora/subscription/widget/header-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionFirstStepView extends StatefulWidget {
  static const String ROUTE_NAME = '/subscription-first-step';

  @override
  _SubscriptionFirstStepState createState() => _SubscriptionFirstStepState();
}

class _SubscriptionFirstStepState extends State<SubscriptionFirstStepView> {
  final Map<int, Widget> views = {
    HousingTypeView.INDEX: HousingTypeView(),
    FloorView.INDEX: FloorView(),
    AddressView.INDEX: AddressView(),
    RentPriceView.INDEX: RentPriceView(),
    QuoteView.INDEX: QuoteView()
  };

  @override
  Widget build(BuildContext context) {
    return GenericView(
      header: HeaderGenericWidget(
          isFixed: true,
          title: allTranslations.text("type_home.title"),
          bottomLeft: HeaderComponent(
              width: 44,
              height: 44,
              icon: CustomPaint(
                painter: CircleSteps(step: 1),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 22,
                    child: Small(
                      "1/4",
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
              return views[provider.currentPageQuote];
            },
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexQuote(HousingTypeView.INDEX, notify: false);
  }
}
