import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/utils/Functions.dart';

class BackgroundLogin extends StatelessWidget{
  BackgroundLogin({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    double padding = MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom;

    double height = heightByPercent(context, 50) + padding;

    return Container(
      constraints: BoxConstraints(
        minHeight: 370
      ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Constants.Colors.BACKGROUND_WHITE,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          ),
        ),
        height: height,
        padding: EdgeInsets.only(bottom: padding),
        child: child
    );
  }
}