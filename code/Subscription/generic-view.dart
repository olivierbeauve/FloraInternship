import 'package:flora/subscription/widget/header-widget.dart';
import 'package:flutter/material.dart';

class GenericView extends StatelessWidget {
  final HeaderGenericWidget header;
  final Widget content;
  const GenericView({Key key, this.header, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: header,
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return content;
          }, childCount: 1),
        ),
      ],
    ));
  }
}
