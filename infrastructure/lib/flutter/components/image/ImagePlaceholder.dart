/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:core/constants/Colors.dart' as Constants;
import 'package:flutter_useful_things/utils/Matrix4Utils.dart';

class ImagePlaceholder extends StatefulWidget {
  @override
  _ImagePlaceholderState createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> rotate;
  Animation<double> rotateReverse;

  @override
  void initState() {
    super.initState();
    var duration = Duration(seconds: 1);
    controller = AnimationController(
      vsync: this,
      duration: duration
    );

    rotate = Tween(begin: 0.0, end: math.pi).animate(controller);
    rotateReverse = Tween(begin: math.pi, end: 0.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.repeat();

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: rotate,
          builder: (context, child) {
            return Container(
              height: 33,
              width: 33,
              transform: Matrix4Utils.rotateByCenter(33, rotate.value),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Constants.Colors.PRIMARY_SWATCH, width: 1, style: BorderStyle.solid)
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: rotateReverse,
          builder: (context, child) {
            return Container(
              height: 28,
              width: 28,
              transform: Matrix4Utils.rotateByCenter(28, rotateReverse.value),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Constants.Colors.PRIMARY_SWATCH, width: 1, style: BorderStyle.solid)
              ),
            );
          },
        ),
        Icon(Icons.image, color: Constants.Colors.PRIMARY_SWATCH, size: 24,)
      ],
    );
  }
}
