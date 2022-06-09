import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/dto/create-account-request.dart';
import 'package:flora/@common/dto/rocketstate-address-detail-dto.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/@common/kit-ui-v2/text/abstract-text.dart';
import 'package:flora/@common/kit-ui-v2/text/h5.dart';
import 'package:flora/@common/scaffold/base-view-v2.dart';
import 'package:flora/@common/service/be-locality-service.dart';
import 'package:flora/@common/service/rockstate-service.dart';
import 'package:flora/@common/state-management/subscription-provider.dart';
import 'package:flora/subscription/step-1/floor-view.dart';
import 'package:flora/subscription/step-1/housing-type-view.dart';
import 'package:flora/subscription/step-1/rent-price-view.dart';
import 'package:flora/subscription/widget/chat-opening.dart';
import 'package:flora/subscription/widget/dropdown-field.dart';
import 'package:flora/subscription/widget/header-small-modal.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flora/subscription/widget/previous-next-buttons.dart';
import 'package:flora/subscription/widget/small-modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressView extends StatefulWidget {
  static const String ROUTE_NAME = '/address';
  static const int INDEX = 2;

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<AddressView> {
  List<String> countries = ["France", "Belgique", "Espagne", "Italie"];
  final GlobalKey<FormBuilderState> _formBuilderKey =
      GlobalKey<FormBuilderState>();

  bool isAddressNotFound = false;
  RockStateService rockStateService = RockStateService();
  bool loading = false;
  List<String> localities;
  BeLocalityService beLocalityService = BeLocalityService();

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
                            allTranslations.text('address.sub_title'),
                            color: KitUIColors.NEUTRAL_100,
                            fontWeight: FontWeightEnum.Bold,
                            textAlign: TextAlign.left,
                          )),
                    ],
                  ),
                  FormBuilder(
                    key: _formBuilderKey,
                    initialValue: {
                      "country": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.country,
                      "street": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.streetName,
                      "number": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.streetNumber,
                      "box": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.box,
                      "postal_code": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.postalCode,
                      "city": Provider.of<SubscriptionProvider>(context,
                              listen: false)
                          .request
                          .contact
                          .address
                          ?.city
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FormBuilderField(
                          name: "country",
                          builder: ((formBuilderState) {
                            return DropdownField(
                              label: allTranslations.text('address.country'),
                              placeholder:
                                  allTranslations.text('address.country'),
                              width: 358,
                              listItems: countries,
                              onChanged: (String value) {
                                formBuilderState.didChange(value);
                                formBuilderState.validate();
                                setState(() {
                                  Provider.of<SubscriptionProvider>(context,
                                          listen: false)
                                      .request
                                      .contact
                                      .address
                                      .country = value;
                                });
                              },
                              initialValue: Provider.of<SubscriptionProvider>(
                                      context,
                                      listen: false)
                                  .request
                                  .contact
                                  .address
                                  ?.country,
                              errorText: formBuilderState.errorText,
                            );
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderField(
                                name: "street",
                                builder: ((formBuilderState) {
                                  return InputField(
                                    label:
                                        allTranslations.text('address.street'),
                                    placeholder: allTranslations
                                        .text('address.street_placeholder'),
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
                                            .address
                                            ?.streetName,
                                  );
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderField(
                              name: "number",
                              builder: ((formBuilderState) {
                                return InputField(
                                    label:
                                        allTranslations.text('address.number'),
                                    placeholder: allTranslations
                                        .text('address.number_placeholder'),
                                    width: 171,
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
                                            .address
                                            ?.streetNumber);
                              }),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.required',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_number')
                                        })),
                                FormBuilderValidators.numeric(context,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.numeric',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_number')
                                        })),
                                FormBuilderValidators.maxLength(context, 6,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.maxLength',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_number'),
                                          'charLength': '6'
                                        }))
                              ]),
                            ),
                            Padding(padding: EdgeInsets.only(right: 16)),
                            FormBuilderField(
                              name: "box",
                              builder: ((formBuilderState) {
                                return InputField(
                                    label: allTranslations.text('address.box'),
                                    placeholder: allTranslations
                                        .text('address.box_placeholder'),
                                    width: 171,
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
                                            .address
                                            ?.box);
                              }),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.maxLength(context, 3,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.maxLength',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_box'),
                                          'charLength': '3'
                                        }))
                              ]),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderField(
                              name: "postal_code",
                              builder: ((formBuilderState) {
                                return InputField(
                                    label: allTranslations
                                        .text('address.postal_code'),
                                    placeholder: allTranslations.text(
                                        'address.postal_code_placeholder'),
                                    width: 171,
                                    onChanged: (String value) {
                                      formBuilderState.didChange(value);
                                      formBuilderState.validate();
                                      handleLocalities();
                                    },
                                    errorText: formBuilderState.errorText,
                                    initialValue:
                                        Provider.of<SubscriptionProvider>(
                                                context,
                                                listen: false)
                                            .request
                                            .contact
                                            .address
                                            ?.postalCode);
                              }),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.required',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_postal_code')
                                        })),
                                FormBuilderValidators.numeric(context,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.numeric',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_postal_code')
                                        })),
                                FormBuilderValidators.minLength(context, 4,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.minLength',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_postal_code'),
                                          'charLength': '4'
                                        })),
                                FormBuilderValidators.maxLength(context, 4,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.maxLength',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_postal_code'),
                                          'charLength': '4'
                                        }))
                              ]),
                            ),
                            Padding(padding: EdgeInsets.only(right: 16)),
                            FormBuilderField(
                              name: "city",
                              builder: ((formBuilderState) {
                                return DropdownField(
                                  label: allTranslations.text('address.city'),
                                  placeholder: allTranslations
                                      .text('address.city_placeholder'),
                                  width: 171,
                                  listItems: localities,
                                  onChanged: (String value) {
                                    formBuilderState.didChange(value);
                                    formBuilderState.validate();
                                    setState(() {
                                      Provider.of<SubscriptionProvider>(context,
                                              listen: false)
                                          .request
                                          .contact
                                          .address
                                          .city = value;
                                    });
                                  },
                                  initialValue:
                                      Provider.of<SubscriptionProvider>(context,
                                              listen: false)
                                          .request
                                          .contact
                                          .address
                                          ?.city,
                                  errorText: formBuilderState.errorText,
                                );
                              }),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: allTranslations.text(
                                        'common.form.validation.field.required',
                                        options: {
                                          'field': allTranslations.text(
                                              'document.contract.move.address.input_txt_city')
                                        }))
                              ]),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  isAddressNotFound
                      ? Column(
                          children: [
                            Container(
                                width: 358,
                                alignment: Alignment.centerLeft,
                                child: Small(
                                  allTranslations.text(
                                      "document.contract.move.address.not_found"),
                                  color: KitUIColors.ERROR_50,
                                  textAlign: TextAlign.left,
                                )),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            ChatOpening(),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: PreviousNextButtons(
                  onPressedNext: handlePressedConfirm,
                  onPressedPrevious: () =>
                      Provider.of<SubscriptionProvider>(context, listen: false)
                                  .request
                                  .property
                                  .type ==
                              "Apartment"
                          ? Provider.of<SubscriptionProvider>(context,
                                  listen: false)
                              .setIndexQuote(FloorView.INDEX)
                          : Provider.of<SubscriptionProvider>(context,
                                  listen: false)
                              .setIndexQuote(HousingTypeView.INDEX),
                  isLoading: loading,
                  isDisable: loading,
                )),
          ],
        ),
      ),
    );
  }

  Widget floodModalContent() {
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
                      child: SvgIcons.FLOOD2.toIcon(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: H4(
                      allTranslations.text("address.sorry_smiley"),
                      fontWeight: FontWeightEnum.Bold,
                      color: KitUIColors.NEUTRAL_100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 358,
                      child: P(
                        allTranslations.text("address.restricted_address"),
                        color: KitUIColors.NEUTRAL_100,
                        textAlign: TextAlign.center,
                      ),
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

  void handleLocalities() async {
    if (this._formBuilderKey.currentState.fields['postal_code'].isValid &&
        this._formBuilderKey.currentState.fields['postal_code'].value.length ==
            4) {
      beLocalityService
          .getLocalities(
              this._formBuilderKey.currentState.fields['postal_code'].value)
          .then((response) {
        final List<String> items = [];
        response.forEach((element) {
          items.add(element.fields.column_2);
        });
        setState(() {
          this.localities = [];
          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .contact
              .address
              .city = null;
          this._formBuilderKey.currentState.fields['city'].didChange(null);
          if (items.length > 0) {
            this.localities = items;
            Provider.of<SubscriptionProvider>(context, listen: false)
                .request
                .contact
                .address
                .city = items.first;
            this
                ._formBuilderKey
                .currentState
                .fields['city']
                .didChange(items.first);
          }
        });
      });
    }
  }

  void handlePressedConfirm() async {
    if (this._formBuilderKey.currentState.saveAndValidate()) {
      setState(() {
        loading = true;
      });
      if (this._formBuilderKey.currentState.value['country'].trim() ==
          "Belgique") {
        RocketStateAddressDetailDTO addressDTO =
            await rockStateService.getAddress(
                this._formBuilderKey.currentState.value['street'].trim(),
                this._formBuilderKey.currentState.value['number'].trim(),
                this._formBuilderKey.currentState.value['postal_code'].trim(),
                this._formBuilderKey.currentState.value['city'].trim());
        if (addressDTO == null) {
          setState(() {
            isAddressNotFound = true;
          });
        } else if (!isFloodingAddress(addressDTO) ||
            (Provider.of<SubscriptionProvider>(context, listen: false)
                        .request
                        .property
                        .type ==
                    "Apartment" &&
                !Provider.of<SubscriptionProvider>(context, listen: false)
                    .groundFloor)) {
          setState(() {
            isAddressNotFound = false;
          });

          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .contact
              .address
              .streetName = this._formBuilderKey.currentState.value['street'];
          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .contact
              .address
              .streetNumber = this._formBuilderKey.currentState.value['number'];
          Provider.of<SubscriptionProvider>(context, listen: false)
              .request
              .contact
              .address
              .box = this._formBuilderKey.currentState.value['box'];
          Provider.of<SubscriptionProvider>(context, listen: false)
                  .request
                  .contact
                  .address
                  .postalCode =
              this._formBuilderKey.currentState.value['postal_code'];

          Provider.of<SubscriptionProvider>(context, listen: false).localities =
              this.localities;

          Provider.of<SubscriptionProvider>(context, listen: false)
              .setIndexQuote(RentPriceView.INDEX);
        } else {
          SmallModal.smallModal(
              context,
              HeaderSmallModal(
                  text: allTranslations.text("address.sorry_header")),
              floodModalContent());
        }
      } else {
        SmallModal.smallModal(
            context,
            HeaderSmallModal(text: allTranslations.text("address.oups_header")),
            justBelgiumModalContent());
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.localities =
        Provider.of<SubscriptionProvider>(context, listen: false).localities;
    if (this.localities == null) this.localities = [];

    if (Provider.of<SubscriptionProvider>(context, listen: false)
            .request
            .contact
            .address ==
        null) {
      Provider.of<SubscriptionProvider>(context, listen: false)
          .request
          .contact
          .address = Address();
    }
  }

  bool isFloodingAddress(RocketStateAddressDetailDTO address) {
    if (address.f_dist_xy_flood <= 5) {
      return true;
    }
    return false;
  }

  Widget justBelgiumModalContent() {
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
                      child: SvgIcons.BELGIUM3.toIcon(),
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
                        allTranslations.text("address.restricted_country"),
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
                    text: allTranslations.text("address.understood"),
                    onPressed: () => Navigator.pop(context)),
              ),
            ),
          ],
        ));
  }

  launchEthiasWebsite() async {
    const url = 'https://flora.insure/fr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
