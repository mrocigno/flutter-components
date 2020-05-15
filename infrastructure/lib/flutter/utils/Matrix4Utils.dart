/*
* Created to flutter-components at 05/14/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';

class Matrix4Utils {

  static Matrix4 rotateByCenter(double size, double rotate) => Matrix4.identity()
    ..translate(size/2, size/2)
    ..multiply(Matrix4.rotationZ(rotate))
    ..translate(-(size/2), -(size/2));

}