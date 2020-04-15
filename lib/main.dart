import 'dart:developer' as dev;

import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/CategoryRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/WhiteTable.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsBloc.dart';
import 'package:mopei_app/src/ui/main/cart/CartBloc.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/splash/SplashScreen.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with WidgetsBindingObserver{

  static void configSystemStyleUI(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  @override
  StatelessElement createElement() {
    //TODO if need context, create a method to initialize one time in build
    Injection.initialize(initializer);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return super.createElement();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    configSystemStyleUI();
    WidgetsBinding.instance.addObserver(this);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Constants.Colors.PRIMARY_SWATCH,
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
//      home: WhiteTable(),
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

  final InjectionInitializer initializer = (module) {

    module.singleton(() => ProductsLocal());
    module.singleton(() => ProductsRemote());

    module.singleton(() => CategoryLocal());
    module.singleton(() => CategoryRemote());

    module.singleton(() => ProductsRepository(
      local: Injection.inject(),
      remote: Injection.inject()
    ));
    module.singleton(() => CategoryRepository(
      local: Injection.inject(),
      remote: Injection.inject()
    ));

    module.singleton(() => CartRepository());

    module.singleton(() => HomeBloc(
      categoryRepository: Injection.inject(),
      productsRepository: Injection.inject()
    ));

    module.singleton(() => CartBloc(
      cartRepository: Injection.inject()
    ));

    module.singleton(() => MainNavigationBloc());
    module.factory(() => ProductDetailsBloc());
  };

}