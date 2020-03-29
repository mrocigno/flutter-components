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

    return Stack(
      children: <Widget>[
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Constants.Colors.BOTTOM_NAVIGATION_BAR_COLOR,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
          ),
          height: double.infinity,
          width: double.infinity,
//          child: Image.asset("assets/loginBackground.png",
//            fit: BoxFit.cover,
//          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: child
          ),
        )
      ],
    );
  }
}