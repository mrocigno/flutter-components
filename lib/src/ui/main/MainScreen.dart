import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/constants/Numbers.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:mopei_app/main.dart';
import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/main/cart/CartScreen.dart';
import 'package:mopei_app/src/ui/main/home/HomeScreen.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigation.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/main/sos/SosScreen.dart';
import 'package:mopei_app/src/ui/main/user/UserScreen.dart';
import 'package:mopei_app/src/ui/notification/NotificationModal.dart';

class MainScreen extends BaseScreen {

  final MainNavigationBloc navigationBloc = sharedBloc();

  @override
  String get name => "MainScreen";

  @override
  void onComeback() {
    super.onComeback();
    navigationBloc.checkCart();
    MyApp.configSystemStyleUI();
  }

  @override
  void onCalled() {
    super.onCalled();
    navigationBloc.checkCart();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Background(
      title: StreamBuilder<int>(
        stream: navigationBloc.page,
        initialData: MainNavigationBloc.INIT_PAGE,
        builder: (context, snapshot) {
          if(snapshot.data == 0) return Image.asset("assets/img/icLogo.webp", height: LOGO_HEIGHT, width: LOGO_WIDTH);
          return Text(Strings.strings["main_title_${snapshot.data}"]);
        },
      ),
      showDrawer: true,
      bottomNavigation: MainNavigation(),
      onWillPop: () {
        int page = navigationBloc.getPage();
        navigationBloc.setPage(0);
        return Future.sync(() => page == 0);
      },
      actions: [
        AppBarAction(
          imgPath: "assets/img/icNotification.png",
          onTap: () => NotificationModal(context).show(),
        )
      ],
      child: StreamBuilder<int>(
        stream: navigationBloc.page,
        initialData: MainNavigationBloc.INIT_PAGE,
        builder: (context, snapshot) {
          switch(snapshot.data){
            case 0: return HomeScreen();
            case 1: return CartScreen();
            case 2: return SosScreen();
            case 3: return UserScreen();
            default: return HomeScreen();
          }
        },
      ),
    );
  }

}