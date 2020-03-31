import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'dart:developer' as dev;

class BackgroundContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;

  BackgroundContainer({
    this.child,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Constants.Colors.BACKGROUND_WHITE_GRAY,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
            ),
          ),
        ),
        Container(
          child: child,
          padding: padding,
        )
      ],
    );
  }
}