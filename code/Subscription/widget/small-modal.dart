import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flutter/material.dart';

class SmallModal {
  static Future<dynamic> smallModal(context, Widget header, Widget content) {
    return showModalBottomSheet(
      barrierColor: KitUIColors.BLACK.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
              child: Column(
            children: [header, content],
          )),
        );
      },
    );
  }
}
