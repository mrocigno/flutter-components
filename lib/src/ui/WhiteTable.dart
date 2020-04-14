import 'dart:developer' as dev;

import 'package:domain/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:infrastructure/flutter/animations/BumpAnimate.dart';
import 'package:infrastructure/flutter/animations/AnimatedStar.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:rxdart/subjects.dart';

class WhiteTable extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: AnimatedStar( autoStart: true,)
        )
      ),
    );
  }
}