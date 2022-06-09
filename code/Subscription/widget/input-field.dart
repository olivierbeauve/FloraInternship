import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final Widget suffix;
  final double width;
  final Function(String) onChanged;
  final String errorText;
  final bool enable;
  final bool isPassword;
  final TextEditingController textController;
  final String initialValue;
  final Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  InputField(
      {this.label,
      this.placeholder,
      this.width,
      this.onChanged,
      this.errorText,
      this.enable = true,
      this.isPassword,
      this.textController,
      this.initialValue,
      this.validator,
      this.suffix,
      this.inputFormatters,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: enable ? 1 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[buildInput()],
        ));
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
          child: TextFormField(
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              initialValue: initialValue,
              onChanged: onChanged,
              obscureText:
                  isPassword != null && isPassword == true ? true : false,
              style: TextStyle(
                  color: (errorText == null || errorText.length == 0)
                      ? KitUIColors.NEUTRAL_100
                      : KitUIColors.ERROR_50,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              decoration: inputDecoration()),
        )
      ],
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      filled: true,
      fillColor: KitUIColors.WHITE,
      enabled: true,
      suffixIcon: suffix,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.NEUTRAL_20, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KitUIColors.NEUTRAL_20, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      errorText: errorText,
      hintText: placeholder,
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
