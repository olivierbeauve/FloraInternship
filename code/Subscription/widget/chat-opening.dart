import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flora/@common/kit-ui-v2/icons.dart';
import 'package:flora/chat/view/chat-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatOpening extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(ChatView.ROUTE_NAME),
      child: Container(
        width: 358,
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
              color: KitUIColors.WHITE,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: KitUIColors.NEUTRAL_20,
                    offset: Offset(0, 2))
              ]),
          child: CircleAvatar(
              backgroundColor: KitUIColors.WHITE,
              radius: 28,
              child: SvgIcons.CHAT
                  .toIcon(color: KitUIColors.PRIMARY_50, height: 28)),
        ),
      ),
    );
  }
}
