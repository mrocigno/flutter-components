import 'dart:developer' as dev;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class BottomScaffoldContainer extends StatelessWidget{

  final Color color;
  final Widget child;

  BottomScaffoldContainer({
    this.color = Colors.white,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    var bottom =
      Platform.isIOS? (MediaQuery.of(context).padding.bottom)
          : (MediaQuery.of(context).viewInsets.bottom);

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