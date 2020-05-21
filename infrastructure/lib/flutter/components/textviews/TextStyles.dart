import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'dart:developer' as dev;

class TextStyles {

  static const TextStyle titleBlack = TextStyle(
    color: Colors.black,
    fontSize: 30,
  );

  static const TextStyle title2Black = TextStyle(
    color: Colors.black,
    fontSize: 25,
  );

  static const TextStyle title2White = TextStyle(
    color: Colors.white,
    fontSize: 25,
  );

  static const TextStyle subtitleBlack = TextStyle(
    color: Colors.black,
    fontSize: 20,
  );

  static const TextStyle subtitleBlackBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20,
  );

  static const TextStyle subtitleWhite = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static const TextStyle subtitleWhiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 20,
  );

  static const TextStyle body = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  static const TextStyle bodyWhite = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle poppinsMedium = TextStyle(
    color: Constants.Colors.GRAY,
    fontSize: 17
  );

  static const TextStyle poppinsSmall = TextStyle(
    color: Constants.Colors.GRAY,
    fontSize: 15
  );

}