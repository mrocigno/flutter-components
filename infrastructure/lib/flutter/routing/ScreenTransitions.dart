import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:flutter_useful_things/base/BaseScreen.dart';
import 'package:flutter_useful_things/routing/AppRoute.dart';

class ScreenTransitions {

  static void _registerObservers(BaseScreen screen) {
    if(screen is RouteObserverMixin){
      AppRoute.register(screen.name, screen as RouteObserverMixin);
    }
  }

  static void pushReplacement(BuildContext context, BaseScreen screen, {Animations animation = Animations.FADE}){
    _registerObservers(screen);
    Navigator.pushReplacement(context, PageRouteBuilder(
      settings: RouteSettings(name: screen.name),
      pageBuilder: (context, animation, secondaryAnimation) => BaseScreenStateful(screen),
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: _getAnimation(animation),
    ));
  }

  static Future<void> push(BuildContext context, BaseScreen screen, {Animations animation = Animations.SLIDE_DOWN}) {
    _registerObservers(screen);
    return Navigator.push(context, PageRouteBuilder(
      settings: RouteSettings(name: screen.name),
      pageBuilder: (context, animation, secondaryAnimation) => BaseScreenStateful(screen),
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: _getAnimation(animation),
    ));
  }

  static RouteTransitionsBuilder _getAnimation(Animations animation) {
    switch(animation){
      case Animations.FADE: return (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      };
      case Animations.SLIDE_DOWN: return (context, animation, secondaryAnimation, child) {
        Animation<Offset> offset = Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset(0, 0),
        ).animate(animation);

        return SlideTransition(
            position: offset,
            child: child
        );
      };
    }
  }

}

enum Animations {
  FADE,
  SLIDE_DOWN
}