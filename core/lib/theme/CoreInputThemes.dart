import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/inputs/InputText.dart';

class CoreInputThemes {

  static InputThemes whiteBackground = InputThemes(
      textColor: Colors.white,
      hintColor: Color.fromRGBO(255, 255, 255, .5),
      iconFit: BoxFit.contain,
      background: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Constants.Colors.WHITE_TRANSPARENT_MEDIUM
      )
  );

  static InputThemes blackBackground = InputThemes(
    textColor: Colors.white,
    hintColor: Color.fromRGBO(255, 255, 255, .5),
    iconFit: BoxFit.contain,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOW
    )
  );

  static InputThemes loginTheme = InputThemes(
      textColor: Colors.black,
      hintColor: Color.fromRGBO(0, 0, 0, .5),
      iconFit: BoxFit.contain,
      background: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Constants.Colors.BLACK_TRANSPARENT_LOW
      )
  );

  static InputThemes searchLightTheme = InputThemes(
    textColor: Colors.white,
    hintColor: Color.fromRGBO(255, 255, 255, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOW,
      border: Border.all(
        width: 1,
        style: BorderStyle.solid,
        color: Constants.Colors.WHITE_TRANSPARENT_MEDIUM
      )
    )
  );

  static InputThemes searchDarkTheme = InputThemes(
    textColor: Colors.black,
    hintColor: Color.fromRGBO(0, 0, 0, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Constants.Colors.BLACK_TRANSPARENT_LOWER,
      border: Border.all(
        width: 1,
        style: BorderStyle.solid,
        color: Constants.Colors.BLACK_TRANSPARENT_LOW
      )
    )
  );

  static InputThemes searchSolidTheme = InputThemes(
    textColor: Colors.black,
    hintColor: Color.fromRGBO(0, 0, 0, .5),
    iconFit: BoxFit.scaleDown,
    background: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white
    )
  );

}