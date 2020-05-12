import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/containers/BackgroundContainer.dart';
import 'package:infrastructure/flutter/components/inputs/InputController.dart';
import 'package:infrastructure/flutter/components/inputs/InputText.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/home/pagecategories/PageCategories.dart';
import 'package:mopei_app/src/ui/main/home/pagefavorites/PageFavorites.dart';
import 'package:mopei_app/src/ui/main/home/pagehighlights/PageHighlights.dart';
import 'package:mopei_app/src/ui/search/SearchScreen.dart';

class HomeScreen extends StatelessWidget {

  final HomeBloc bloc = inject();
  final InputController searchController = InputController();

  void goToSearchScreen(BuildContext context){
    var screen = SearchScreen(
      initialData: searchController.value.text
    );
    ScreenTransitions.push(context, screen, animation: Animations.FADE);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.refreshHighlights();
      bloc.refreshCategories();
    });

    return Column(
      children: [
        Hero(
          tag: "SearchField",
          child: Material(
            color: Colors.transparent,
            child: Input(InputThemes.searchLightTheme,
              controller: searchController,
              icon: "assets/img/icSearchWhite.png",
              margin: EdgeInsets.all(20),
              onFieldSubmitted: (value) => goToSearchScreen(context),
              onTapIcon: () => goToSearchScreen(context),
            ),
          ),
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
                    PageHighlights(),
                    PageCategories(),
                    PageFavorites()
                  ],
                )
            )
        )
      ],
    );
  }
}