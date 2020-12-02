import 'dart:developer' as dev;

import 'package:data/mapper/CartMapper.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:data/mapper/CreditCardMapper.dart';
import 'package:data/mapper/FavoriteMapper.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/mapper/SearchMapper.dart';
import 'package:data/mapper/UserMapper.dart';
import 'package:data/remote/interceptor/UserInterceptor.dart';
import 'package:data/remote/service/AutoCompleteService.dart';
import 'package:data/remote/service/CategoryService.dart';
import 'package:data/remote/service/PhotoService.dart';
import 'package:data/remote/service/ProductService.dart';
import 'package:data/remote/service/UserService.dart';
import 'package:data/repository/AutoCompleteRepository.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/CategoryRepository.dart';
import 'package:data/repository/CreditCardRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/PhotoRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_useful_things/components/containers/TopSnackBar.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/observer/ConnectionObserver.dart';
import 'package:flutter_useful_things/routing/AppRoute.dart';
import 'package:mopei_app/src/ui/WhiteTable.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsBloc.dart';
import 'package:mopei_app/src/ui/login/pagelogin/PageLoginBloc.dart';
import 'package:mopei_app/src/ui/main/cart/CartBloc.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/main/user/UserBloc.dart';
import 'package:mopei_app/src/ui/payment/CardListBloc.dart';
import 'package:mopei_app/src/ui/payment/addCard/AddCreditCardBloc.dart';
import 'package:mopei_app/src/ui/search/SearchBloc.dart';
import 'package:mopei_app/src/ui/splash/SplashScreen.dart';
import 'package:core/constants/Colors.dart' as Constants;
import 'package:rxdart/rxdart.dart';
import 'package:mock/MockInterceptor.dart';
import 'package:mock/ui/MockBubble.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with WidgetsBindingObserver, ConnectionBindingObserver{

  final BehaviorSubject<bool> _hasConnection = BehaviorSubject();

  static void configSystemStyleUI(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  @override
  StatelessElement createElement() {
    Injection.initialize(initializer);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return super.createElement();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    configSystemStyleUI();
    WidgetsBinding.instance.addObserver(this);
    ConnectionBinding.instance.addObserver(this);

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [AppRoute()],
      theme: ThemeData(
        primarySwatch: Constants.Colors.PRIMARY_SWATCH,
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            child,
            StreamBuilder(
              stream: _hasConnection.stream,
              initialData: true,
              builder: (context, snapshot) {
                if(snapshot.data) return Wrap();
                return TopSnackBar(
                  autoClose: false,
                  onClickCloseButton: () => _hasConnection.add(true),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      Icon(Icons.wifi, color: Colors.white, size: 24),
                      Text("Sem conexão", style: TextStyles.subtitleWhite)
                    ],
                  )
                );
              },
            )
          ],
        );
      },
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

  @override
  void onLostConnection() {
    dev.log("lost");
    _hasConnection.add(false);
  }

  @override
  void onGrantConnection() {
    dev.log("grant");
    _hasConnection.add(true);
  }

  final InjectionInitializer initializer = (module) {
    module.singleton(() => ProductService());
    module.singleton(() => CategoryService());
    module.singleton(() => UserService());
    module.singleton(() => PhotoService());
    module.singleton(() => AutoCompleteService());

    module.singleton(() => ProductsRepository());
    module.singleton(() => CategoryRepository());
    module.singleton(() => FavoritesRepository());
    module.singleton(() => CartRepository());
    module.singleton(() => UserRepository());
    module.singleton(() => PhotoRepository());
    module.singleton(() => CreditCardRepository());
    module.singleton(() => AutoCompleteRepository());

    module.bloc(() => HomeBloc());
    module.bloc(() => CartBloc());
    module.bloc(() => MainNavigationBloc());
    module.bloc(() => UserBloc());
    module.bloc(() => ProductDetailsBloc());
    module.bloc(() => SearchBloc());
    module.bloc(() => PageLoginBloc());
    module.bloc(() => CardListBloc());
    module.bloc(() => AddCreditCardBloc());

    module.singleton(() => CartMapper());
    module.singleton(() => FavoriteMapper());
    module.singleton(() => CategoryMapper());
    module.singleton(() => ProductMapper());
    module.singleton(() => UserMapper());
    module.singleton(() => PhotoMapper());
    module.singleton(() => CreditCardMapper());
    module.singleton(() => SearchMapper());

    module.singleton(() {
      var dio = Dio(BaseOptions(
        baseUrl: "https://api.mopei.com/"
      ));
      dio.interceptors.add(UserInterceptor(dio));
//      dio.interceptors.add(LogInterceptor());
//      if(kDebugMode)
      dio.interceptors.add(MockInterceptor(dio));
      return dio;
    });
  };

}