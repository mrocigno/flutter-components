

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class BackgroundThemes {

  static BackgroundThemes main = BackgroundThemes(
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
    centralizeTitle: true,
    titleColor: Constants.Colors.COLOR_PRIMARY,
    decoration: BoxDecoration(
      color: Constants.Colors.BACKGROUND_WHITE_GRAY
    )
  );

  static BackgroundThemes loginPage = BackgroundThemes(
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

  BackgroundThemes({this.decoration, this.centralizeTitle, this.titleColor});

  final BoxDecoration decoration;
  final bool centralizeTitle;
  final Color titleColor;
}