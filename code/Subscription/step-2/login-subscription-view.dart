import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/service/firebase-service.dart';
import 'package:flora/@common/service/shared-preferences-service.dart';
import 'package:flora/@common/state-management/account-provider.dart';
import 'package:flora/@common/state-management/auth-provider.dart';
import 'package:flora/@common/state-management/base-provider.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/landing/landing-view.dart';
import 'package:flora/subscription/step-2/reset-password-subscription-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class LoginSubscriptionView extends StatefulWidget {
  static const String ROUTE_NAME = '/login-subscription';
  static const int INDEX = 2;
  @override
  _LoginSubscriptionState createState() => _LoginSubscriptionState();
}

class _LoginSubscriptionState extends State<LoginSubscriptionView> {
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();

  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  bool haveLoginError = false;
  bool isLoading = false;
  TextEditingController _userNameTextEditingController =
      TextEditingController();

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
              Column(children: [
                Container(
                  width: 358,
                  padding: EdgeInsets.only(top: 16),
                  child: H5(
                    allTranslations.text('login.msg_title'),
                    color: KitUIColors.NEUTRAL_100,
                    fontWeight: FontWeightEnum.Bold,
                    textAlign: TextAlign.left,
                  ),
                ),
              ]),
              FormBuilder(
                key: _formBuilderKey,
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      FormBuilderField(
                        name: "email",
                        builder: ((formBuilderState) {
                          return InputField(
                              label: allTranslations
                                  .text('account_creation.mail_address'),
                              placeholder: allTranslations
                                  .text('account_creation.mail_address'),
                              width: 358,
                              onChanged: (String value) {
                                haveLoginError = false;
                                formBuilderState.didChange(value);
                                if (formBuilderState.errorText != null) {
                                  formBuilderState.validate();
                                }
                              },
                              errorText: formBuilderState.errorText,
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
                          ],
                        ),
                      ),
                    ]),
                    FormBuilderField(
                      name: "password",
                      builder: ((formBuilderState) {
                        return InputField(
                          label:
                              allTranslations.text('account_creation.password'),
                          placeholder:
                              allTranslations.text('account_creation.password'),
                          width: 358,
                          onChanged: (String value) {
                            haveLoginError = false;
                            formBuilderState.didChange(value);
                            if (formBuilderState.errorText != null) {
                              formBuilderState.validate();
                            }
                          },
                          errorText: formBuilderState.errorText,
                          isPassword: true,
                        );
                      }),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(context,
                              errorText: allTranslations.text(
                                  'common.form.validation.field.required')),
                          (value) {
                            if (this.haveLoginError) {
                              return allTranslations.text('login.msg_error');
                            }
                            return null;
                          }
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          ChatOpening(),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 32),
            child: Column(
              children: [
                Container(
                  width: 358,
                  height: 48,
                  child: BtnPrimaryBase(
                      isDisable: isLoading,
                      isLoading: isLoading,
                      text: allTranslations.text('login.btn_connect'),
                      onPressed: _connect),
                ),
                Container(
                  width: 358,
                  height: 48,
                  child: BtnTertiaryBase(
                    text: allTranslations.text('login.btn_password_forgotten'),
                    onTap: _handleResetPassword,
                    color: KitUIColors.NEUTRAL_50,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _prefillUserData();
  }

  Future<void> _configureSession() async {
    FirebaseService firebaseService = FirebaseService();
    firebaseService.configure();
    AccountService accountService = AccountService();
    accountService.updateAccountSetLogged(
        firebaseToken: await _sharedPreferencesService.getFirebaseToken());
  }

  void _connect() async {
    this.haveLoginError = false;
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      _loading(true);
      if (await this._login() == true) {
        _loading(false);
        await this._configureSession();
        this._gotoLanding();
      } else {
        _loading(false);
        this.haveLoginError = true;
        this._formBuilderKey.currentState.validate();
      }
    }
  }

  void _gotoLanding() async {
    await Provider.of<AccountProvider>(context, listen: false).reset();
    await Provider.of<BaseProvider>(context, listen: false).reset();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LandingView.ROUTE_NAME, (Route<dynamic> route) => false);
  }

  void _handleResetPassword() {
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexAccount(ResetPasswordSubscriptionView.INDEX);
  }

  _loading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<bool> _login() async {
    try {
      var cs = this._formBuilderKey.currentState;
      await Provider.of<AuthProvider>(context, listen: false).signIn(
          cs.value['email'].toString().toLowerCase().trim(),
          cs.value['password']);
      return true;
    } catch (error) {
      return false;
    }
  }

  void _prefillUserData() {
    _sharedPreferencesService.getUsername().then((String value) {
      setState(() {
        _userNameTextEditingController.text = value;
        _formBuilderKey.currentState.fields['email'].didChange(value);
      });
    });
  }
}
