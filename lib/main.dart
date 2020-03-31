import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopei_app/src/ui/splash/SplashScreen.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with WidgetsBindingObserver{

  static void configSystemStyleUI(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    configSystemStyleUI();

    WidgetsBinding.instance.addObserver(this);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(systemNavigationBarIconBrightness: Brightness.dark),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Constants.Colors.PRIMARY_SWATCH,
          fontFamily: 'Lato',
        ),
        home: SplashScreen(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    configSystemStyleUI();
  }

  @override
  // ignore: missing_return
  Future<bool> didPushRoute(String route) {
    configSystemStyleUI();
  }


}

//V operator [](Object key);
//
///**
// * Associates the [key] with the given [value].
// *
// * If the key was already in the map, its associated value is changed.
// * Otherwise the key/value pair is added to the map.
// */
//void operator []=(K key, V value);