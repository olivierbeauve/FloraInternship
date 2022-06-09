import 'package:flora/@common/kit-ui-v2/colors.dart';
import 'package:flora/@common/kit-ui-v2/text/abstract-text.dart';
import 'package:flora/@common/kit-ui-v2/text/h5.dart';
import 'package:flora/@common/kit-ui-v2/text/text-index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderComponent {
  final dynamic onPressed;
  final Widget icon;
  final double width;
  final double height;
  final String text;

  HeaderComponent(
      {this.onPressed, this.icon, this.width, this.height, this.text});
}

class HeaderGenericWidget extends SliverPersistentHeaderDelegate {
  final String title;
  final HeaderComponent topLeft;
  final HeaderComponent topRight;
  final HeaderComponent bottomRight;
  final HeaderComponent bottomLeft;
  final bool isFixed;

  HeaderGenericWidget(
      {this.title,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft,
      this.isFixed});

  @override
  double get maxExtent => 152;

  @override
  double get minExtent => isFixed ? maxExtent : 92;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 152,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 56),
                      child: buildIconComponent(component: topLeft),
                    ),
                    Positioned(
                      bottom: 16,
                      left: (152 - constraints.maxHeight) > 0
                          ? (152 - constraints.maxHeight)
                          : 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildIconComponent(component: bottomLeft),
                          Padding(padding: EdgeInsets.only(left: 16)),
                          constraints.maxHeight < 97
                              ? H5(
                                  title,
                                  color: KitUIColors.NEUTRAL_100,
                                  fontWeight: FontWeightEnum.Bold,
                                )
                              : constraints.maxHeight < 151
                                  ? Text(title,
                                      style: TextStyle(
                                          fontSize: constraints.maxHeight / 4.8,
                                          color: KitUIColors.NEUTRAL_100,
                                          fontWeight: FontWeight.bold))
                                  : H3(
                                      title,
                                      color: KitUIColors.NEUTRAL_100,
                                      fontWeight: FontWeightEnum.Bold,
                                    )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(top: 56),
                      child: buildIconComponent(component: topRight),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: (bottomRight != null && bottomRight.text == null) ||
                            constraints.maxHeight < 130
                        ? buildIconComponent(component: bottomRight)
                        : buildTextComponent(component: bottomRight),
                  )
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: KitUIColors.WHITE,
          boxShadow: [
            BoxShadow(
              color: KitUIColors.NEUTRAL_10,
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, -4),
            ),
          ],
        ),
      );
    });
  }

  Widget buildIconComponent({@required HeaderComponent component}) {
    return component != null
        ? GestureDetector(
            onTap: component.onPressed,
            child: Container(
              width: component.width != null ? component.width : 24,
              height: component.height != null ? component.height : 24,
              child: component.icon,
            ),
          )
        : Container();
  }

  Widget buildTextComponent({@required HeaderComponent component}) {
    return component != null
        ? GestureDetector(
            onTap: component.onPressed,
            child: Container(
              child: H5(
                component.text,
                color: KitUIColors.PRIMARY_50,
                fontWeight: FontWeightEnum.Bold,
              ),
            ),
          )
        : Container();
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
}
