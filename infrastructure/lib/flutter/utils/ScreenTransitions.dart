import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ScreenTransitions {

  static Map<String, RouteTransitionsBuilder> _transitions = {
    "fade": (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  };

  static void pushReplacement(BuildContext context, Widget screen){
    Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: _transitions["fade"],
    ));
  }

}