/*
* Created to flutter-components at 05/30/2020
*/
import "dart:developer" as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter_useful_things/base/BaseScreen.dart';
import 'package:flutter_useful_things/routing/AppRoute.dart';

abstract class BaseFragment<T extends StatefulWidget> extends State<T> implements RouteObserverMixin {

  @override
  void deactivate() {
    super.deactivate();
    BaseScreen.of(context).unregister(this);
  }

  @override
  Widget build(BuildContext context) {
    BaseScreen.of(context).register(this);
    return buildFragment(context);
  }

  Widget buildFragment(BuildContext context);

  @override
  void onCalled() {}

  @override
  void onComeback() {}

  @override
  void onExit() {}

  @override
  void onPause() {}

}