import 'dart:developer' as dev;

import 'package:data/repository/FavoriteRepositoryImpl.dart';
import 'package:domain/usecase/FavoritesUseCase.dart';
import 'package:domain/usecase/HighlightsUseCase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopei_app/src/di/Injection.dart';
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

    Injection.initialize(context, initializer);

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

  InjectionInitializer initializer = (list) {

    //region Data Source
    list.addAll([
      FavoriteLocal(),
      FavoriteRemote()
    ]);
    //endregion

    //region Repositories
    list.addAll([
      FavoriteRepositoryImpl(Injection.inject())
    ]);
    //endregion

    //region Use Cases
    list.addAll([
      HighlightsUseCase(favoriteRepository: Injection.inject()),
      FavoritesUseCase(favoriteRepository: Injection.inject())
    ]);
    //endregion
  };

}