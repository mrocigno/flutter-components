import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/constants/Routes.dart' as Constants;
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:mopei_app/src/ui/splash/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Constants.Colors.BOTTOM_NAVIGATION_BAR_COLOR,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
//      routes: {
//        Constants.Routes.HOME_SCREEN: (context) => HomeScreen()
//      },
    );
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