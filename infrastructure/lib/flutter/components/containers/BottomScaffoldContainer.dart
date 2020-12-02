import 'dart:developer' as dev;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/utils/Functions.dart';

class BottomScaffoldContainer extends StatelessWidget{

  final Color color;
  final Widget child;

  BottomScaffoldContainer({
    this.color = Colors.white,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    var bottom = insetBottom(context);

    return Material(
      color: color,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: child
      ),
    );
  }

}