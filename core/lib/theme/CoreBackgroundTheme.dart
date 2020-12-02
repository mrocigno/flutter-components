import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/backgrounds/BackgroundTheme.dart';
import 'package:core/constants/Colors.dart' as Constants;

class CoreBackgroundTheme {

  static BackgroundTheme main = BackgroundTheme(
    titleColor: Colors.white,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Constants.Colors.GRADIENT_BACKGROUND_INI,
          Constants.Colors.GRADIENT_BACKGROUND_END
        ]
      )
    )
  );

  static BackgroundTheme details = BackgroundTheme(
    titleColor: Constants.Colors.COLOR_PRIMARY,
    statusBarBrightness: Brightness.light,
    decoration: BoxDecoration(
      color: Constants.Colors.BACKGROUND_WHITE
    )
  );

  static BackgroundTheme test = BackgroundTheme(
    titleColor: Constants.Colors.COLOR_PRIMARY,
    decoration: BoxDecoration(
      color: Colors.transparent
    )
  );

  static BackgroundTheme loginPage = BackgroundTheme(
    titleColor: Colors.black,
    decoration: BoxDecoration(
//      color: Constants.Colors.BLACK_TRANSPARENT,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
        )
    )
  );
}