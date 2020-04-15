import 'dart:developer' as dev;

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
    return Material(
      color: color,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child
      ),
    );
  }

}