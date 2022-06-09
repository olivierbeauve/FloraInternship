import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/home/home-view.dart';
import 'package:flora/subscription/step-2/create-account-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullView extends StatefulWidget {
  static const String ROUTE_NAME = '/full-view';

  @override
  _FullViewState createState() => _FullViewState();
}

class _FullViewState extends State<FullView> {
  Widget build(context) {
    ArgsFullView arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 56.0, right: 16),
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, HomeView.ROUTE_NAME),
                  child: Container(
                      width: 24,
                      height: 24,
                      child:
                          SvgIcons.CROSS.toIcon(color: KitUIColors.PRIMARY_50)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: arguments.icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: H4(
                      arguments.title,
                      textAlign: TextAlign.center,
                      color: KitUIColors.NEUTRAL_100,
                      fontWeight: FontWeightEnum.Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: P(
                      arguments.subTitle,
                      textAlign: TextAlign.center,
                      color: KitUIColors.NEUTRAL_100,
                      fontWeight: FontWeightEnum.Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 358,
                      child: P(
                        arguments.description,
                        textAlign: TextAlign.center,
                        color: KitUIColors.NEUTRAL_70,
                      ),
                    ),
                  ),
                  P(
                    Provider.of<SubscriptionProvider>(context, listen: false)
                        .request
                        .contact
                        .email,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeightEnum.Bold,
                    color: KitUIColors.NEUTRAL_70,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Container(
                width: 174,
                height: 48,
                child: BtnTertiaryBase(
                  text:
                      allTranslations.text("email_sent.btn_no_email_received"),
                  onTap: arguments.onTap,
                  color: KitUIColors.PRIMARY_50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
