import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-3/already-assured-view.dart';
import 'package:flora/subscription/step-3/payment-method-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class MovingDateContractView extends StatefulWidget {
  static const String ROUTE_NAME = '/moving_date_contract';
  static const int INDEX = 2;

  @override
  _MovingDateContractState createState() => _MovingDateContractState();
}

class _MovingDateContractState extends State<MovingDateContractView> {
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();
  bool loading = false;

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
                    allTranslations.text('subscription_step.date.title'),
                    color: KitUIColors.NEUTRAL_100,
                    fontWeight: FontWeightEnum.Bold,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: 358,
                  child: P(
                    allTranslations.text('subscription_step.date.sub_title'),
                    color: KitUIColors.NEUTRAL_70,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    width: 358,
                    child: FormBuilder(
                      key: _formBuilderKey,
                      initialValue: {
                        "start_date": Provider.of<SubscriptionProvider>(context,
                                listen: false)
                            .request
                            .policy
                            ?.startDate
                      },
                      child: FormBuilderField(
                        name: "start_date",
                        builder: ((formBuilderState) {
                          return InputField(
                            label: allTranslations
                                .text('subscription_step.date.date'),
                            placeholder: allTranslations
                                .text('subscription_step.date.date'),
                            width: 358,
                            onChanged: (String value) {
                              formBuilderState.didChange(value);
                              formBuilderState.validate();
                            },
                            errorText: formBuilderState.errorText,
                            keyboardType: TextInputType.datetime,
                            initialValue: Provider.of<SubscriptionProvider>(
                                    context,
                                    listen: false)
                                .request
                                .policy
                                ?.startDate,
                          );
                        }),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context,
                                errorText: allTranslations.text(
                                    'common.form.validation.field.required')),
                            FormBuilderValidators.match(context,
                                r'^(?:0[1-9]|[12]\d|3[01])([\/])(?:0[1-9]|1[012])\1(?:19|20)\d\d$',
                                errorText: allTranslations.text(
                                  'common.form.validation.field.date',
                                )),
                            isHigherThanToday(context,
                                errorText: allTranslations.text(
                                    "subscription_step.date.date_too_low"))
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
                  onPressedNext: () => handlePressedConfirm(),
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .setIndexSubscription(AlreadyAssuredView.INDEX),
                  isLoading: loading,
                  isDisable: loading,
                ))
          ],
        ),
      ),
    );
  }

  void handlePressedConfirm() {
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .policy
          .startDate = this._formBuilderKey.currentState.value['start_date'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .setIndexSubscription(PaymentMethodView.INDEX);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  static FormFieldValidator<T> isHigherThanToday<T>(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      DateTime now = DateTime.now();
      DateTime tomorrow = DateTime(now.year, now.month, now.day + 1, 0);
      var valueCandidateFormatted = valueCandidate.toString().split("/");
      DateTime dateCandidate = DateTime.parse(valueCandidateFormatted[2] +
          valueCandidateFormatted[1] +
          valueCandidateFormatted[0]);

      if (dateCandidate.isBefore(tomorrow)) return errorText;
      return null;
    };
  }
}
