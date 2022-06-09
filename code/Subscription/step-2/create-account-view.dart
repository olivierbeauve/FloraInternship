import 'package:enum_to_string/enum_to_string.dart';
import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/create-account-request.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/account-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/full-view.dart';
import 'package:flora/subscription/step-2/login-subscription-view.dart';
import 'package:flora/subscription/step-2/resent-email-view.dart';
import 'package:flora/subscription/widget/header-small-modal.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flora/subscription/widget/small-modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ArgsFullView {
  Widget icon;
  String title;
  String subTitle;
  String description;
  Function onTap;
}

class CreateAccountView extends StatefulWidget {
  static const String ROUTE_NAME = '/info-before-create-account';
  static const int INDEX = 0;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountView> {
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();
  final AccountService accountService = AccountService();

  bool loading = false;
  bool isCheckedFirstCondition = false;
  bool isCheckedSecondCondition = false;
  bool isCheckedThirdCondition = false;
  String passValue;
  bool hasAlreadyAnAccount = false;

  Widget blacklistedContentModal() {
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
                      child: SvgIcons.BLACKLIST.toIcon(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: H4(
                      allTranslations.text("address.oups_smiley"),
                      fontWeight: FontWeightEnum.Bold,
                      color: KitUIColors.NEUTRAL_100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 358,
                      child: P(
                        allTranslations
                            .text("subscription_step.message_blacklisted"),
                        color: KitUIColors.NEUTRAL_100,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Container(
                width: 358,
                height: 48,
                child: BtnPrimaryBase(
                    text: allTranslations.text("subscription_step.understood"),
                    onPressed: () => Navigator.pop(context)),
              ),
            ),
          ],
        ));
  }

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
                          allTranslations.text('account_creation.description'),
                          color: KitUIColors.NEUTRAL_100,
                          fontWeight: FontWeightEnum.Bold,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      hasAlreadyAnAccount
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Container(
                                    width: 358,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: KitUIColors.NEUTRAL_10,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(8)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 16),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgIcons.ATTENTION
                                                    .toIcon(
                                                        color: KitUIColors
                                                            .ERROR_50),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: P(
                                                  allTranslations.text(
                                                      "account_creation.attention"),
                                                  fontWeight:
                                                      FontWeightEnum.Bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 48, top: 8),
                                          child: Row(
                                            children: [
                                              Small(
                                                allTranslations.text(
                                                    "account_creation.already_an_account"),
                                                color: KitUIColors.NEUTRAL_70,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Container(
                                    width: 248,
                                    height: 48,
                                    child: BtnTertiaryBase(
                                      text: allTranslations.text(
                                          "account_creation.already_account"),
                                      onTap: () =>
                                          Provider.of<SubscriptionProvider>(
                                                  context,
                                                  listen: false)
                                              .setIndexAccount(
                                                  LoginSubscriptionView.INDEX),
                                      color: KitUIColors.PRIMARY_50,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                  FormBuilder(
                    key: _formBuilderKey,
                    initialValue: {
                      "firstname": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.firstname,
                      "lastname": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.name,
                      "birthdate": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.birthDate,
                      "phone_number": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.phoneNumber,
                      "mail_address": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.email,
                      "password": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          ?.password,
                    },
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "firstname",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations
                                        .text('account_creation.firstname'),
                                    placeholder: allTranslations
                                        .text('account_creation.firstname'),
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
                                            ?.firstname,
                                  );
                                }),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.required')),
                                    FormBuilderValidators.maxLength(context, 35,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.maxLength',
                                            options: {
                                              'field': allTranslations.text(
                                                  'account_creation.firstname'),
                                              'charLength': '35'
                                            }))
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "lastname",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations
                                        .text('account_creation.lastname'),
                                    placeholder: allTranslations
                                        .text('account_creation.lastname'),
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
                                            ?.name,
                                  );
                                }),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.required')),
                                    FormBuilderValidators.maxLength(context, 35,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.maxLength',
                                            options: {
                                              'field': allTranslations.text(
                                                  'account_creation.lastname'),
                                              'charLength': '35'
                                            }))
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "birthdate",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations
                                        .text('account_creation.birthdate'),
                                    placeholder: allTranslations
                                        .text('account_creation.birthdate'),
                                    width: 358,
                                    onChanged: (String value) {
                                      formBuilderState.didChange(value);
                                      formBuilderState.validate();
                                    },
                                    errorText: formBuilderState.errorText,
                                    keyboardType: TextInputType.datetime,
                                    initialValue:
                                        Provider.of<SubscriptionProvider>(
                                                context,
                                                listen: false)
                                            .request
                                            .contact
                                            ?.birthDate,
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
                                        ))
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "phone_number",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations
                                        .text('account_creation.phone_number'),
                                    placeholder: allTranslations
                                        .text('account_creation.phone_number'),
                                    width: 358,
                                    onChanged: (String value) {
                                      formBuilderState.didChange(value);
                                      formBuilderState.validate();
                                    },
                                    errorText: formBuilderState.errorText,
                                    keyboardType: TextInputType.phone,
                                    initialValue:
                                        Provider.of<SubscriptionProvider>(
                                                context,
                                                listen: false)
                                            .request
                                            .contact
                                            ?.phoneNumber,
                                  );
                                }),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.required')),
                                    FormBuilderValidators.match(context,
                                        r'^(\+)(297|93|244|1264|358|355|376|971|54|374|1684|1268|61|43|994|257|32|229|226|880|359|973|1242|387|590|375|501|1441|591|55|1246|673|975|267|236|1|61|41|56|86|225|237|243|242|682|57|269|238|506|53|5999|61|1345|357|420|49|253|1767|45|1809|1829|1849|213|593|20|291|212|34|372|251|358|679|500|33|298|691|241|44|995|44|233|350|224|590|220|245|240|30|1473|299|502|594|1671|592|852|504|385|509|36|62|44|91|246|353|98|964|354|972|39|1876|44|962|81|76|77|254|996|855|686|1869|82|383|965|856|961|231|218|1758|423|94|266|370|352|371|853|590|212|377|373|261|960|52|692|389|223|356|95|382|976|1670|258|222|1664|596|230|265|60|262|264|687|227|672|234|505|683|31|47|977|674|64|968|92|507|64|51|63|680|675|48|1787|1939|850|351|595|970|689|974|262|40|7|250|966|249|221|65|500|4779|677|232|503|378|252|508|381|211|239|597|421|386|46|268|1721|248|963|1649|235|228|66|992|690|993|670|676|1868|216|90|688|886|255|256|380|598|1|998|3906698|379|1784|58|1284|1340|84|678|681|685|967|27|260|263)(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{4,20}$',
                                        errorText: allTranslations.text(
                                          'common.form.validation.field.phone_number',
                                        ))
                                  ],
                                ),
                              ),
                            ]),
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
                                            'common.form.validation.field.required')),
                                    FormBuilderValidators.maxLength(context, 35,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.maxLength',
                                            options: {
                                              'field': allTranslations.text(
                                                  'document.contract.move.address.input_txt_street'),
                                              'charLength': '35'
                                            })),
                                    FormBuilderValidators.email(context,
                                        errorText: allTranslations.text(
                                          'change_email.form.validation.invalid',
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "password",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations
                                        .text('account_creation.password'),
                                    placeholder: allTranslations.text(
                                        'account_creation.password_choose'),
                                    width: 358,
                                    onChanged: (String value) {
                                      setState(() {
                                        passValue = value;
                                      });
                                      formBuilderState.didChange(value);
                                      formBuilderState.validate();
                                    },
                                    errorText: formBuilderState.errorText,
                                    isPassword: true,
                                    initialValue:
                                        Provider.of<SubscriptionProvider>(
                                                context,
                                                listen: false)
                                            .request
                                            .contact
                                            ?.password,
                                  );
                                }),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.required')),
                                    FormBuilderValidators.minLength(context, 8,
                                        errorText: allTranslations.text(
                                            'common.form.validation.invalidPassword')),
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "password_confirm",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label: allTranslations.text(
                                        'account_creation.password_confirmation'),
                                    placeholder: allTranslations.text(
                                        'account_creation.password_confirm'),
                                    width: 358,
                                    onChanged: (String value) {
                                      formBuilderState.didChange(value);
                                      formBuilderState.validate();
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
                                    FormBuilderValidators.equal(
                                        context, passValue,
                                        errorText: allTranslations.text(
                                            'common.form.validation.field.equal',
                                            options: {
                                              'field': allTranslations.text(
                                                  'account_creation.password_confirmation'),
                                              'field2': allTranslations.text(
                                                  'account_creation.password')
                                            })),
                                  ],
                                ),
                              ),
                            ]),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Container(
                                width: 358,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        checkColor: KitUIColors.WHITE,
                                        activeColor: KitUIColors.PRIMARY_50,
                                        side: BorderSide(
                                            color: KitUIColors.NEUTRAL_20,
                                            width: 2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.4))),
                                        value: isCheckedFirstCondition,
                                        onChanged: (value) {
                                          setState(() {
                                            isCheckedFirstCondition = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 8)),
                                    Container(
                                      width: 326,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          P(
                                            allTranslations.text(
                                                'summary.declaration_part1'),
                                            color: KitUIColors.NEUTRAL_100,
                                            textAlign: TextAlign.left,
                                          ),
                                          GestureDetector(
                                            onTap: getConditions,
                                            child: Text(
                                              allTranslations.text(
                                                  "summary.declaration_part2"),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  height: 24 / 16,
                                                  color:
                                                      KitUIColors.NEUTRAL_100,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                          P(
                                            allTranslations.text(
                                                'summary.declaration_part3'),
                                            color: KitUIColors.NEUTRAL_100,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Container(
                                width: 358,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        checkColor: KitUIColors.WHITE,
                                        activeColor: KitUIColors.PRIMARY_50,
                                        side: BorderSide(
                                            color: KitUIColors.NEUTRAL_20,
                                            width: 2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.4))),
                                        value: isCheckedSecondCondition,
                                        onChanged: (value) {
                                          setState(() {
                                            isCheckedSecondCondition = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 8)),
                                    Container(
                                      width: 326,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            P(
                                              allTranslations.text(
                                                  'account_creation.accept_advantages_offers'),
                                              color: KitUIColors.NEUTRAL_100,
                                              textAlign: TextAlign.left,
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Container(
                                width: 358,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        checkColor: KitUIColors.WHITE,
                                        activeColor: KitUIColors.PRIMARY_50,
                                        side: BorderSide(
                                            color: KitUIColors.NEUTRAL_20,
                                            width: 2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.4))),
                                        value: isCheckedThirdCondition,
                                        onChanged: (value) {
                                          setState(() {
                                            isCheckedThirdCondition = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 8)),
                                    Container(
                                      width: 326,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            P(
                                              allTranslations.text(
                                                  'account_creation.accept_partners'),
                                              color: KitUIColors.NEUTRAL_100,
                                              textAlign: TextAlign.left,
                                            )
                                          ]),
                                    ),
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
                                    text: allTranslations.text(
                                        "account_creation.create_account"),
                                    isLoading: loading,
                                    isDisable:
                                        loading || !isCheckedFirstCondition,
                                    onPressed: handlePressedConfirm),
                              ),
                              Container(
                                width: 358,
                                height: 48,
                                child: BtnTertiaryBase(
                                  text: allTranslations
                                      .text("type_home.previous"),
                                  onTap: () => Navigator.pop(context),
                                  color: KitUIColors.NEUTRAL_50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getConditions() async {
    const url =
        'https://flora.insure/wp-content/uploads/2020/09/Assurance-incendie-locataire-Flora-Insurance-conditions-generales-fr.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void goToResentEmailView() async {
    Provider.of<SubscriptionProvider>(context, listen: false)
        .setIndexAccount(ResentEmailView.INDEX);
    Navigator.pop(context);
  }

  void handlePressedConfirm() async {
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      setState(() {
        loading = true;
      });

      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .firstname = this._formBuilderKey.currentState.value['firstname'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .name = this._formBuilderKey.currentState.value['lastname'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .birthDate = this._formBuilderKey.currentState.value['birthdate'];
      Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .contact
              .phoneNumber =
          this._formBuilderKey.currentState.value['phone_number'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .email = this._formBuilderKey.currentState.value['mail_address'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .password = this._formBuilderKey.currentState.value['password'];
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .language = EnumToString.convertToString(LANGUAGE.Fr);

      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .marketingOptin = isCheckedSecondCondition;

      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .marketingPartnerBenefitsOptin = isCheckedThirdCondition;

      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .policy
          .product = "PropertyRenter";

      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .address
          .countryCode = "BE";

      List<bool> response = await accountService.createAccount(
          Provider.of<SubscriptionProvider>(context, listen: false).request);
      if (response != null && response.length > 2 && response[0]) {
        bool emailExist = response[1];
        bool validation = response[2];
        if (emailExist) {
          setState(() {
            hasAlreadyAnAccount = true;
          });
        } else if (!validation) {
          SmallModal.smallModal(
              context,
              HeaderSmallModal(
                  text: allTranslations.text('address.oups_header')),
              blacklistedContentModal());
        } else if (!emailExist && validation) {
          ArgsFullView args = ArgsFullView();
          args.icon = SvgIcons.MAIL2.toIcon();
          args.title = allTranslations.text("email_sent.msg_email_received2");
          args.subTitle =
              allTranslations.text("email_sent.msg_email_received_sub_4");
          args.description =
              allTranslations.text("email_sent.msg_email_received_sub_5");
          args.onTap = goToResentEmailView;

          Navigator.pushNamed(context, FullView.ROUTE_NAME, arguments: args);
        }
      } else {
        Toast.show(
            allTranslations.text("common.error_page.client_error"), context);
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .contact ==
        null)
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact = Contact();
    else
      passValue = Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .password;
  }
}
