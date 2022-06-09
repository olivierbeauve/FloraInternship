import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CreditCardField extends StatelessWidget {
  final String label;
  final double width;
  final String errorText;
  final Function(CardFieldInputDetails) onCardChanged;

  CreditCardField({this.label, this.width, this.errorText, this.onCardChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[buildInput()],
    );
  }

  Widget buildInput() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 16)),
        Container(
          width: width,
          height: 16,
          child: Row(
            children: [
              XSmall(
                label,
                textAlign: TextAlign.left,
                color: KitUIColors.NEUTRAL_50,
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Container(
            width: width,
            child: CardField(
              expirationHintText:
                  allTranslations.text("profile.payment.hint_expiration"),
              decoration: inputDecoration(),
              onCardChanged: onCardChanged,
            ))
      ],
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      filled: true,
      fillColor: KitUIColors.WHITE,
      enabled: true,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.NEUTRAL_20, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.NEUTRAL_20, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      errorText: errorText,
      hintStyle: TextStyle(
          color: KitUIColors.NEUTRAL_40,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.ERROR_50, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.ERROR_50, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      errorMaxLines: 3,
      errorStyle: TextStyle(
          color: KitUIColors.ERROR_50,
          fontSize: 12,
          fontWeight: FontWeight.w400),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.PRIMARY_50, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.NEUTRAL_20, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
