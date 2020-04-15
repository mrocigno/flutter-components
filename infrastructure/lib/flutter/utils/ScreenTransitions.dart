import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ScreenTransitions {

  static Map<String, RouteTransitionsBuilder> _transitions = {
    "fade": (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    "downSlide": (context, animation, secondaryAnimation, child) {
      Animation<Offset> offset = Tween<Offset>(
        begin: Offset(0, -1),
        end: Offset(0, 0),
      ).animate(animation);

      return SlideTransition(
        position: offset,
        child: child
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

  static void push(BuildContext context, Widget screen){
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: _transitions["downSlide"],
    ));
  }

}