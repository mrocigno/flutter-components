import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class BackgroundLogin extends StatelessWidget{
  BackgroundLogin({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    double padding = MediaQuery.of(context).viewInsets.bottom;
    double height = (MediaQuery.of(context).size.height / 2) + padding;

    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Constants.Colors.BACKGROUND_WHITE,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          ),
        ),
        height: height,
        padding: EdgeInsets.only(bottom: padding),
        child: child
    );
  }
}