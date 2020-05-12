

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class BackgroundThemes {

  static BackgroundThemes main = BackgroundThemes(
    statusBarBrightness: Brightness.dark,
    centralizeTitle: true,
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

  static BackgroundThemes details = BackgroundThemes(
    statusBarBrightness: Brightness.light,
    centralizeTitle: true,
    pinned: true,
    elevation: 3,
    appBarColor: Colors.white,
    titleColor: Constants.Colors.COLOR_PRIMARY,
    decoration: BoxDecoration(
      color: Constants.Colors.BACKGROUND_WHITE_GRAY
    )
  );

  static BackgroundThemes search = BackgroundThemes(
    statusBarBrightness: Brightness.light,
    centralizeTitle: true,
    pinned: true,
    titleColor: Constants.Colors.COLOR_PRIMARY,
    appBarColor: Constants.Colors.WHITE_TRANSPARENT_HIGH,
    elevation: 0,
    decoration: BoxDecoration(
      color: Colors.white
    )
  );

  static BackgroundThemes loginPage = BackgroundThemes(
    statusBarBrightness: Brightness.light,
    centralizeTitle: false,
    titleColor: Colors.black,
    decoration: BoxDecoration(
//      color: Constants.Colors.BLACK_TRANSPARENT,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
        )
    )
  );

  BackgroundThemes({this.decoration, this.centralizeTitle, this.titleColor, this.statusBarBrightness, this.pinned = false, this.elevation = 1, this.appBarColor = Colors.transparent});

  final BoxDecoration decoration;
  final bool centralizeTitle;
  final Color titleColor;
  final Brightness statusBarBrightness;
  final bool pinned;
  final double elevation;
  final Color appBarColor;

}