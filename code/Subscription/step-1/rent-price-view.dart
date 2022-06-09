import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/create-account-request.dart';
import 'package:flora/@common/dto/pricing-response.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/pricing-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/@common/util/decimal-text-formatter.dart';
import 'package:flora/subscription/step-1/address-view.dart';
import 'package:flora/subscription/step-1/quote-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/header-small-modal.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flora/subscription/widget/small-modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class RentPriceView extends StatefulWidget {
  static const String ROUTE_NAME = '/rent_price';
  static const int INDEX = 3;

  @override
  _RentPriceState createState() => _RentPriceState();
}

class _RentPriceState extends State<RentPriceView> {
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();
  bool loading = false;

  final PricingService pricingService = PricingService();

  Widget build(context) {
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
                  child: H5(
                    allTranslations.text('rent_price.sub_title'),
                    color: KitUIColors.NEUTRAL_100,
                    fontWeight: FontWeightEnum.Bold,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: 358,
                  child: P(
                    allTranslations.text('rent_price.sub_sub_title'),
                    color: KitUIColors.NEUTRAL_70,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    width: 358,
                    child: FormBuilder(
                      key: _formBuilderKey,
                      initialValue: {
                        "rent_price": Provider.of<SubscriptionProvider>(context,
                                        listen: false)
                                    .request
                                    .property
                                    .rent !=
                                null
                            ? Provider.of<SubscriptionProvider>(context,
                                    listen: false)
                                .request
                                .property
                                .rent
                                .toString()
                            : null
                      },
                      child: FormBuilderField(
                        name: "rent_price",
                        builder: ((formBuilderState) {
                          return InputField(
                            label: allTranslations.text('rent_price.price'),
                            placeholder: allTranslations
                                .text('rent_price.price_placeholder'),
                            width: 358,
                            onChanged: (String value) {
                              formBuilderState.didChange(value);
                              formBuilderState.validate();
                            },
                            errorText: formBuilderState.errorText,
                            initialValue: Provider.of<SubscriptionProvider>(
                                            context,
                                            listen: false)
                                        .request
                                        .property
                                        .rent !=
                                    null
                                ? Provider.of<SubscriptionProvider>(context,
                                        listen: false)
                                    .request
                                    .property
                                    .rent
                                    .toString()
                                : null,
                            suffix: suffixWidget(),
                            inputFormatters: [
                              DecimalTextInputFormatter(decimalRange: 3)
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          );
                        }),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context,
                                errorText: allTranslations.text(
                                    'common.form.validation.field.required',
                                    options: {
                                      'field': allTranslations.text(
                                          'document.contract.move.address.rent_price')
                                    })),
                            FormBuilderValidators.numeric(context,
                                errorText: allTranslations.text(
                                    'common.form.validation.field.numeric',
                                    options: {
                                      'field': allTranslations.text(
                                          'document.contract.move.address.rent_price')
                                    })),
                          ],
                        ),
                      ),
                    )),
              ])
            ])),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: handlePressedConfirm,
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexQuote(AddressView.INDEX),
                  isLoading: loading,
                  isDisable: loading,
                ))
          ],
        ),
      ),
    );
  }

  void handlePressedConfirm() async {
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      setState(() {
        loading = true;
      });
      if (double.parse(this._formBuilderKey.currentState.value['rent_price']) <=
          2000) {
        CreateAccountRequest request =
            Provider.of<SubscriptionProvider>(context, listen: false).request;
        request.property.rent =
            double.parse(this._formBuilderKey.currentState.value['rent_price']);
        PricingResponse pricingResponse = await pricingService.getPricing(
            request.contact.address.postalCode,
            request.property.rent,
            null,
            request.property.type,
            isPublic: true);
        if (pricingResponse != null) {
          Provider.of<SubscriptionProvider>(context, listen: false)
              .setPricingResponse(pricingResponse);
          Provider.of<SubscriptionProvider>(context, listen: false)
              .setIndexQuote(QuoteView.INDEX);
        } else {
          Toast.show(
              allTranslations.text("common.error_page.client_error"), context);
        }
      } else {
        SmallModal.smallModal(
            context,
            HeaderSmallModal(text: allTranslations.text('address.oups_header')),
            tooHighPriceContentModal());
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  launchEthiasWebsite() async {
    const url = 'https://flora.insure/fr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget suffixWidget() {
    return Padding(
        padding: EdgeInsets.only(
          right: 16,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "€/${allTranslations.text("common.month")}",
              style: TextStyle(color: KitUIColors.NEUTRAL_40, fontSize: 16),
            )
          ],
        ));
  }

  Widget tooHighPriceContentModal() {
    return Container(
        height: 353,
        width: MediaQuery.of(context).size.width,
        color: KitUIColors.NEUTRAL_05,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: SvgIcons.BUDGET.toIcon(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: H4(
                      allTranslations.text('address.oups_smiley'),
                      fontWeight: FontWeightEnum.Bold,
                      color: KitUIColors.NEUTRAL_100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 358,
                      child: P(
                          allTranslations.text("rent_price.restricted_price"),
                          textAlign: TextAlign.center,
                          color: KitUIColors.NEUTRAL_100),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 358,
              child: P(
                allTranslations.text("address.ethias_can_help"),
                color: KitUIColors.NEUTRAL_50,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 32),
              child: Container(
                width: 358,
                height: 48,
                child: BtnPrimaryBase(
                    text: allTranslations.text("address.visit_ethias"),
                    onPressed: launchEthiasWebsite),
              ),
            ),
          ],
        ));
  }
}
