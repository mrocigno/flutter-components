import 'package:flutter/material.dart';

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
          height: double.infinity,
          width: double.infinity,
          child: Image.asset("assets/loginBackground.png",
            fit: BoxFit.cover,
          ),
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