import 'package:data/db/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/HomeBottomNavigationBar.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/home/pagecategories/PageCategories.dart';
import 'package:mopei_app/src/ui/home/pagefavorites/PageFavorites.dart';
import 'package:mopei_app/src/ui/home/pagehighlights/PageHighlights.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/login/LoginModal.dart';
import 'package:path/path.dart';


class HomeScreen extends StatelessWidget {

  final HomeBloc bloc = Injection.inject();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.refreshHighlights();
    });

    return Background(
      title: "Mopei",
      showDrawer: true,
      bottomNavigation: HomeBottomNavigationBar(),
      actions: [
        AppBarAction(
          imgPath: "assets/img/icNotification.png",
          onTap: () => LoginModal(context).show(),
        )
      ],
      child: Column(
        children: [
          Input(InputThemes.searchTheme,
            icon: "assets/img/icSearchWhite.png",
            margin: EdgeInsets.all(20),
            onTapIcon: (){
              dev.log("masue");
            },
          ),
          Expanded(
            child: BackgroundContainer(
              child: TabView(
                onPageChange: (page) {
                  switch(page){
                    case 0: bloc.getHighlights(); break;
                    case 1: bloc.getCategories(); break;
                    case 2: bloc.getFavorites(); break;
                  }
                },
                children: [
                  PageHighlights(context),
                  PageCategories(context),
                  PageFavorites(context)
                ],
              )
            )
          )
        ],
      ),
    );
  }


}


