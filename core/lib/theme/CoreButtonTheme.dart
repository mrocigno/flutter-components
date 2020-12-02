import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/buttons/MopeiButton.dart';
import 'package:core/constants/Colors.dart' as Constants;

class CoreButtonTheme {

  static MopeiButtonTheme mainTheme = MopeiButtonTheme(
    TextStyle(
      color: Colors.white
    ),
    BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Constants.Colors.GRADIENT_BUTTON_INI,
          Constants.Colors.GRADIENT_BUTTON_END
        ]
      )
    ),
    BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.grey,
              Colors.blueGrey
            ]
        )
    ),
    0,
    Colors.black
  );

  static MopeiButtonTheme outlined = MopeiButtonTheme(
      TextStyle(
          color: Constants.Colors.GRADIENT_BUTTON_END
      ),
      BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Constants.Colors.GRADIENT_BUTTON_END, style: BorderStyle.solid, width: 1)
      ),
      BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1)
      ),
      2,
      Colors.black
  );

}