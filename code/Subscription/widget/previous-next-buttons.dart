import 'package:flora/@common/config/translation.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';

class PreviousNextButtons extends StatelessWidget {
  final Function onPressedNext;
  final Function onPressedPrevious;
  final bool isLoading;
  final bool isDisable;

  PreviousNextButtons(
      {this.onPressedNext,
      this.onPressedPrevious,
      this.isLoading = false,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 171,
          height: 48,
          child: BtnTertiaryBase(
            text: allTranslations.text("type_home.previous"),
            onTap: onPressedPrevious,
            color: KitUIColors.NEUTRAL_50,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 16)),
        Container(
          width: 171,
          height: 48,
          child: BtnPrimaryBase(
              isLoading: isLoading,
              isDisable: isDisable,
              text: allTranslations.text("type_home.next"),
              onPressed: onPressedNext),
        ),
      ],
    );
  }
}
