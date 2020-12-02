import 'dart:developer' as dev;

import 'package:core/theme/CoreInputThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/carousel/TabView.dart';
import 'package:flutter_useful_things/components/containers/BackgroundContainer.dart';
import 'package:flutter_useful_things/components/inputs/InputController.dart';
import 'package:flutter_useful_things/components/inputs/InputText.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/routing/ScreenTransitions.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';
import 'package:mopei_app/src/ui/main/home/pagecategories/PageCategories.dart';
import 'package:mopei_app/src/ui/main/home/pagefavorites/PageFavorites.dart';
import 'package:mopei_app/src/ui/main/home/pagehighlights/PageHighlights.dart';
import 'package:mopei_app/src/ui/search/SearchScreen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final HomeBloc homeBloc = sharedBloc();
  final InputController searchController = InputController();

  void goToSearchScreen(BuildContext context){
    var screen = SearchScreen(
        initialData: searchController.value.text
    );
    ScreenTransitions.push(context, screen, animation: Animations.FADE);
  }

  @override
  void initState() {
    super.initState();
    homeBloc.refreshHighlights();
    homeBloc.refreshCategories();
    homeBloc.refreshFavorites();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "SearchField",
          child: Material(
            color: Colors.transparent,
            child: Input(CoreInputThemes.searchLightTheme,
                controller: searchController,
                icon: "assets/img/icSearchWhite.png",
                margin: EdgeInsets.all(20),
                onFieldSubmitted: (value) => goToSearchScreen(context),
                onTapIcon: () => goToSearchScreen(context)
            ),
          ),
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
    );
  }

}