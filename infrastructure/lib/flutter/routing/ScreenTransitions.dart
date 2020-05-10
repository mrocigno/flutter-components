import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';

class ScreenTransitions {

  static final RouteTransitionsBuilder _fade = (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  };

  static final RouteTransitionsBuilder _downSlide = (context, animation, secondaryAnimation, child) {
    Animation<Offset> offset = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(animation);

    return SlideTransition(
        position: offset,
        child: child
    );
  };

  static void _registerRoute(BaseScreen screen) {
    if(screen is RouteObserverMixin){
      AppRoute.register(screen.name, screen as RouteObserverMixin);
    }
  }

  static void pushReplacement(BuildContext context, BaseScreen screen){
    _registerRoute(screen);
    Navigator.pushReplacement(context, PageRouteBuilder(
      settings: RouteSettings(name: screen.name),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: _fade,
    ));
  }

  static Future<void> push(BuildContext context, BaseScreen screen) {
    _registerRoute(screen);
    return Navigator.push(context, PageRouteBuilder(
      settings: RouteSettings(name: screen.name),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: _downSlide,
    ));
  }

}