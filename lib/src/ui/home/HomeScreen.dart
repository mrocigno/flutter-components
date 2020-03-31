import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/HomeBottomNavigationBar.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:mopei_app/src/ui/home/pagecategories/PageCategories.dart';
import 'package:mopei_app/src/ui/home/pagefavorites/PageFavorites.dart';
import 'package:mopei_app/src/ui/home/pagehighlights/PageHighlights.dart';
import 'dart:developer' as dev;

import 'package:mopei_app/src/ui/login/LoginModal.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          ),
          Expanded(
            child: BackgroundContainer(
              child: TabView(
                children: [
                  PageHighlights(),
                  PageCategories(),
                  PageFavorites()
                ],
              )
            )
          )
        ],
      ),
    );
  }


}


