import 'package:flora/@common/kit-ui-v2/index.dart';
import 'package:flutter/material.dart';

class HeaderSmallModal extends StatelessWidget {
  final String text;

  HeaderSmallModal({this.text});

  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Column(
        children: [
          Container(
            height: 8,
            width: 40,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: KitUIColors.NEUTRAL_50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 4)
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: KitUIColors.NEUTRAL_10,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              height: 56,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                          child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: P(
                      text,
                      fontWeight: FontWeightEnum.Bold,
                      color: KitUIColors.NEUTRAL_100,
                    ),
                  ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                        width: 24,
                        height: 24,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgIcons.CROSS
                              .toIcon(color: KitUIColors.PRIMARY_50),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
