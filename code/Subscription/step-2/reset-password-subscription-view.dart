import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/change-password/change-password-service.dart';
import 'package:flora/subscription/full-view.dart';
import 'package:flora/subscription/step-2/create-account-view.dart';
import 'package:flora/subscription/step-2/login-subscription-view.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ResetPasswordSubscriptionView extends StatefulWidget {
  static const String ROUTE_NAME = '/reset-password-subscription';
  static const int INDEX = 3;

  @override
  _ResetPasswordSubscriptionState createState() =>
      _ResetPasswordSubscriptionState();
}

class _ResetPasswordSubscriptionState
    extends State<ResetPasswordSubscriptionView> {
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();
  final AccountService accountService = AccountService();
  bool loading = false;
  ChangePasswordService _changePasswordService = ChangePasswordService();

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
                          allTranslations.text("email_sent.resend_mail_title"),
                          color: KitUIColors.NEUTRAL_100,
                          fontWeight: FontWeightEnum.Bold,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  FormBuilder(
                    key: _formBuilderKey,
                    initialValue: {
                      "mail_address": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.email,
                    },
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "mail_address",
                                builder: ((formBuilderState) {
                                  return InputField(
                                      label: allTranslations.text(
                                          'account_creation.mail_address'),
                                      placeholder: allTranslations.text(
                                          'account_creation.mail_address'),
                                      width: 358,
                                      onChanged: (String value) {
                                        formBuilderState.didChange(value);
                                        formBuilderState.validate();
                                      },
                                      errorText: formBuilderState.errorText,
                                      initialValue:
                                          Provider.of<SubscriptionProvider>(
                                                  context,
                                                  listen: false)
                                              .request
                                              .contact
                                              ?.email,
                                      keyboardType: TextInputType.emailAddress);
                                }),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.required',
                                            options: {
                                              'field': allTranslations.text(
                                                  'document.contract.move.address.input_txt_street')
                                            })),
                                    FormBuilderValidators.maxLength(context, 35,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.maxLength',
                                            options: {
                                              'field': allTranslations.text(
                                                  'document.contract.move.address.input_txt_street'),
                                              'charLength': '35'
                                            }))
                                  ],
                                ),
                              ),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 32),
              child: Column(
                children: [
                  Container(
                    width: 358,
                    height: 48,
                    child: BtnPrimaryBase(
                        text: allTranslations
                            .text("account_creation.restore_mdp"),
                        isLoading: loading,
                        isDisable: loading,
                        onPressed: handlePressedConfirm),
                  ),
                  Container(
                    width: 358,
                    height: 48,
                    child: BtnTertiaryBase(
                      text: allTranslations.text("type_home.previous"),
                      onTap: () => Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .setIndexAccount(LoginSubscriptionView.INDEX),
                      color: KitUIColors.NEUTRAL_50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleChange() async {
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexAccount(ResetPasswordSubscriptionView.INDEX);
    Navigator.pop(context);
  }

  void handlePressedConfirm() async {
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      setState(() {
        loading = true;
      });

      String email = Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .email;

      bool reset = await _changePasswordService.resetPassword(email);
      if (reset) {
        ArgsFullView args = ArgsFullView();
        args.icon = SvgIcons.MAIL2.toIcon();
        args.title = allTranslations.text("email_sent.msg_email_received2");
        args.subTitle =
            allTranslations.text("email_sent.msg_email_received_sub");
        args.description =
            allTranslations.text("email_sent.msg_email_received_sub_6");
        args.onTap = handleChange;

        Navigator.pushNamed(context, FullView.ROUTE_NAME, arguments: args);
      } else {
        Toast.show(allTranslations.text('reset_password.impossible'), context);
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
}
