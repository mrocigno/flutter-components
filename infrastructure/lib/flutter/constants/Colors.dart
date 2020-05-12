import 'package:flutter/material.dart';

class Colors {

  static const MaterialColor PRIMARY_SWATCH = MaterialColor(0xFF521588, {
    50:  Color.fromRGBO(82, 21, 136, .1),
    100: Color.fromRGBO(82, 21, 136, .2),
    200: Color.fromRGBO(82, 21, 136, .3),
    300: Color.fromRGBO(82, 21, 136, .4),
    400: Color.fromRGBO(82, 21, 136, .5),
    500: Color.fromRGBO(82, 21, 136, .6),
    600: Color.fromRGBO(82, 21, 136, .7),
    700: Color.fromRGBO(82, 21, 136, .8),
    800: Color.fromRGBO(82, 21, 136, .9),
    900: Color.fromRGBO(82, 21, 136, 1)
  });

  static const Color COLOR_PRIMARY = Color.fromRGBO(82, 21, 136, 1);

  static const Color GRADIENT_BACKGROUND_INI = Color.fromRGBO(31, 20, 49, 1);
  static const Color GRADIENT_BACKGROUND_END = COLOR_PRIMARY;
  static const Color GRADIENT_BUTTON_INI = Color.fromRGBO(155, 111, 255, 1);
  static const Color GRADIENT_BUTTON_END = Color.fromRGBO(104, 91, 255, 1);

  static const Color WHITE_TRANSPARENT_LOW = Color.fromRGBO(255, 255, 255, .3);
  static const Color WHITE_TRANSPARENT_MEDIUM = Color.fromRGBO(255, 255, 255, .5);
  static const Color WHITE_TRANSPARENT_HIGH = Color.fromRGBO(255, 255, 255, .9);

  static const Color BLACK_TRANSPARENT_LOWER = Color.fromRGBO(0, 0, 0, .1);
  static const Color BLACK_TRANSPARENT_LOW = Color.fromRGBO(0, 0, 0, .2);

  static const Color RED_ERROR = Color.fromRGBO(246, 75, 99, 1);

  static const Color BACKGROUND_WHITE_GRAY = Color(0xFFEEEEEE);
  static const Color BACKGROUND_WHITE = Color(0xFFF9F9F9);

  static const Color GRAY = Color.fromRGBO(158, 158, 158, 1);

}