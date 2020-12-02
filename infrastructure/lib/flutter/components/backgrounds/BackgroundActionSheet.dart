import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/utils/Functions.dart';

class BackgroundActionSheet extends StatelessWidget {

  final Widget child;
  final double height;
  final EdgeInsets padding;
  final BoxConstraints constraints;

  BackgroundActionSheet({
    Key key,
    this.child,
    this.height = 0,
    this.padding = const EdgeInsets.all(0),
    this.constraints
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _padding = MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom;

    return Container(
      constraints: constraints,
      clipBehavior: Clip.hardEdge,
      height: height + _padding,
      padding: EdgeInsets.only(
        top: padding.top,
        right: padding.right,
        bottom: _padding + padding.bottom,
        left: padding.left
      ),
      child: child,
      decoration: BoxDecoration(
        color: Constants.Colors.BACKGROUND_WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
      ),
    );
  }
}