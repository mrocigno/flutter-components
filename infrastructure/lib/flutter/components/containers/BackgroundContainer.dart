import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'dart:developer' as dev;

class BackgroundContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;
  final BackgroundContainerTheme theme;

  BackgroundContainer({
    this.child,
    this.padding,
    this.theme = BackgroundContainerTheme.CURVED
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (theme == BackgroundContainerTheme.FLAT? (
          Container(
            color: Constants.Colors.BACKGROUND_MARBLE_MEDIUM,
            margin: EdgeInsets.only(top: 100),
          )
        ) : (
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
              ),
            ),
          )
        )),
        Container(
          child: child,
          padding: padding,
        )
      ],
    );
  }
}

enum BackgroundContainerTheme {
  CURVED,
  FLAT
}