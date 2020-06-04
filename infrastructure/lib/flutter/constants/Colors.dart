import 'package:flutter/material.dart';

class Colors {

  static const MaterialColor PRIMARY_SWATCH = MaterialColor(0xFF105C6F, {
    50:  Color.fromRGBO(6, 92, 111, .1),
    100: Color.fromRGBO(6, 92, 111, .2),
    200: Color.fromRGBO(6, 92, 111, .3),
    300: Color.fromRGBO(6, 92, 111, .4),
    400: Color.fromRGBO(6, 92, 111, .5),
    500: Color.fromRGBO(6, 92, 111, .6),
    600: Color.fromRGBO(6, 92, 111, .7),
    700: Color.fromRGBO(6, 92, 111, .8),
    800: Color.fromRGBO(6, 92, 111, .9),
    900: Color.fromRGBO(6, 92, 111, 1)
  });

  static const Color COLOR_PRIMARY = Color.fromRGBO(6, 92, 111, 1);

  static const Color GRADIENT_BACKGROUND_INI = COLOR_PRIMARY;
  static const Color GRADIENT_BACKGROUND_END = COLOR_PRIMARY;
  static const Color GRADIENT_BUTTON_INI = Color.fromRGBO(46, 201, 233, 1);
  static const Color GRADIENT_BUTTON_END = Color.fromRGBO(19, 210, 186, 1);

  static const Color WHITE_TRANSPARENT_LOW = Color.fromRGBO(255, 255, 255, .3);
  static const Color WHITE_TRANSPARENT_MEDIUM = Color.fromRGBO(255, 255, 255, .5);
  static const Color WHITE_TRANSPARENT_HIGH = Color.fromRGBO(255, 255, 255, .9);

  static const Color BLACK_TRANSPARENT_LOWER = Color.fromRGBO(0, 0, 0, .1);
  static const Color BLACK_TRANSPARENT_LOW = Color.fromRGBO(0, 0, 0, .2);

  static const Color RED_ERROR = Color.fromRGBO(246, 75, 99, 1);

  static const Color BACKGROUND_MARBLE = Color.fromARGB(255, 250, 250, 250);
  static const Color BACKGROUND_MARBLE_MEDIUM = Color(0xFFEEEEEE);
  static const Color BACKGROUND_WHITE = Color(0xFFF9F9F9);

  static const Color GRAY = Color.fromRGBO(158, 158, 158, 1);

}