/*
* Created to flutter-components at 05/09/2020
*/
import "dart:developer" as dev;

import 'package:flutter/material.dart';

abstract class RouteObserverMixin {

  void onComeback() => {};

  void onCalled() => {};

  void onPause() => {};

  void onExit() => {};

}

class AppRoute extends RouteObserver<PageRoute<dynamic>> {

  static final Map<String, RouteObserverMixin> _observers = {};

  static void register(String screenName, RouteObserverMixin mixin){
    _observers[screenName] = mixin;
  }

  void _sendScreenView(PageRoute<dynamic> route, Type type) {
    var screenName = route.settings.name;
    if(screenName != null) {
      var routeObserver = _observers[screenName];
      switch(type){
        case Type.COMEBACK: {
          routeObserver?.onComeback();
          break;
        }
        case Type.CALLED: {
          routeObserver?.onCalled();
          break;
        }
        case Type.PAUSING: {
          routeObserver?.onPause();
          break;
        }
        case Type.EXITING: {
          routeObserver?.onExit();
          break;
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute, Type.COMEBACK);
      _sendScreenView(route, Type.EXITING);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(route, Type.CALLED);
      _sendScreenView(previousRoute, Type.PAUSING);
    }
  }
  
  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    if(newRoute is PageRoute && oldRoute is PageRoute){
      _sendScreenView(newRoute, Type.CALLED);
      _sendScreenView(oldRoute, Type.EXITING);
    }
  }
}

enum Type {
  COMEBACK,
  CALLED,
  EXITING,
  PAUSING
}