import 'package:data/db/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/cart/CartScreen.dart';
import 'package:mopei_app/src/ui/main/home/HomeScreen.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigation.dart';
import 'package:mopei_app/src/ui/main/home/pagecategories/PageCategories.dart';
import 'package:mopei_app/src/ui/main/home/pagefavorites/PageFavorites.dart';
import 'package:mopei_app/src/ui/main/home/pagehighlights/PageHighlights.dart';
import 'package:mopei_app/src/ui/main/navigation/MainNavigationBloc.dart';
import 'package:mopei_app/src/ui/main/sos/SosScreen.dart';
import 'package:mopei_app/src/ui/main/user/UserScreen.dart';
import 'package:path/path.dart';


class MainScreen extends StatelessWidget {

  final MainNavigationBloc navigationBloc = Injection.inject();

  @override
  Widget build(BuildContext context) {
    return Background(
      title: StreamBuilder<int>(
        stream: navigationBloc.page,
        initialData: MainNavigationBloc.INIT_PAGE,
        builder: (context, snapshot) => Text(Strings.strings["main_title_${snapshot.data}"]),
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
          onTap: () => LoginModal(context).show(),
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


