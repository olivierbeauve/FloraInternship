import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flora/subscription/widget/input-field.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final String placeholder;
  final double width;
  final List<String> listItems;
  final Function(String) onChanged;
  final String initialValue;
  final String errorText;

  DropdownField(
      {this.label,
      this.placeholder,
      this.width,
      this.listItems,
      this.onChanged,
      this.initialValue,
      this.errorText});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<DropdownField> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    InputField inputField = InputField(
      errorText: widget.errorText,
      placeholder: widget.placeholder,
    );
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 16)),
        Container(
          width: widget.width,
          height: 16,
          child: Row(
            children: [
              XSmall(
                widget.label,
                textAlign: TextAlign.left,
                color: KitUIColors.NEUTRAL_50,
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        Container(
          width: widget.width,
          color: KitUIColors.NEUTRAL_05,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: KitUIColors.WHITE,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                value: widget.initialValue,
                onChanged: widget.onChanged,
                dropdownPadding: EdgeInsets.only(top: 0, bottom: 0),
                isDense: true,
                decoration: inputField.inputDecoration(),
                offset: const Offset(0, -8),
                dropdownDecoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: KitUIColors.NEUTRAL_20,
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: Offset(0, 0),
                      ),
                    ],
                    border: Border.all(color: KitUIColors.NEUTRAL_20, width: 1),
                    borderRadius: new BorderRadius.all(Radius.circular(8))),
                onTap: () => {
                  setState(() {
                    isOpened = true;
                  }),
                },
                onMenuClose: () => {
                  setState(() {
                    isOpened = false;
                  }),
                },
                selectedItemHighlightColor:
                    KitUIColors.PRIMARY_50.withOpacity(0.2),
                itemHeight: 40,
                icon: isOpened
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SvgIcons.CHEVRON_UP
                            .toIcon(color: KitUIColors.PRIMARY_50),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SvgIcons.CHEVRON_DOWN
                            .toIcon(color: KitUIColors.PRIMARY_50),
                      ),
                selectedItemBuilder: (BuildContext context) => widget.listItems
                    .map<Widget>((String item) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(item),
                          ],
                        ))
                    .toList(),
                items: widget.listItems.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: P(
                        value,
                        color: widget.initialValue == value
                            ? KitUIColors.NEUTRAL_100
                            : KitUIColors.NEUTRAL_70,
                      ));
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
