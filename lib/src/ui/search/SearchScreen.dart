/*
* Created to flutter-components at 05/10/2020
*/
import 'dart:core';
import 'dart:core';
import "dart:developer" as dev;
import 'dart:math';

import 'package:data/local/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/Background.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundSliver.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundThemes.dart';
import 'package:infrastructure/flutter/components/backgrounds/FlexibleSpaceSearchBar.dart';
import 'package:infrastructure/flutter/components/textviews/EmptyState.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';
import 'package:mopei_app/src/ui/search/SearchBloc.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

class SearchScreen extends BaseScreen with RouteObserverMixin {

  @override
  String get name => "SearchScreen";

  final SearchBloc searchBloc = bloc();
  final String initialData;

  SearchScreen({this.initialData = ""});

  @override
  void onCalled() {
    if(initialData != "") {
      searchBloc.performSearch(initialData);
    }
  }

  @override
  void onComeback() {
    searchBloc.notifyDataChange();
  }

  GlobalKey<FlexibleSpaceSearchBarState> _searchHeaderKey;

  @override
  void initState() {
    super.initState();
    _searchHeaderKey = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    searchBloc.close();
  }

  @override
  Widget buildScreen(BuildContext context) {
    Duration duration = Duration(milliseconds: 300);

    return BackgroundSliver(
      theme: BackgroundThemes.search,
      expandedHeight: 130,
      actions: [
        AppBarAction(
          icon: Icon(Icons.filter_list, color: Constants.Colors.PRIMARY_SWATCH),
        )
      ],
      flexibleSpaceBar: FlexibleSpaceSearchBar(
        key: _searchHeaderKey,
        initialData: initialData,
        loadObserver: searchBloc.products.loading,
        onPerformSearch: (search) {
          if(search != ""){
            searchBloc.performSearch(search);
          }
        },
      ),
      child: Stack(
        children: <Widget>[
          StreamBuilder<Exception>(
            stream: searchBloc.products.error,
            builder: (context, snapshot) {
              var show = snapshot.hasData;
              return AnimatedOpacity(
                duration: duration,
                opacity: show? 1 : 0,
                child: Center(
                  child: EmptyState(
                    title: "Houve um erro",
                    titleStyle: TextStyle(color: Colors.redAccent, fontSize: 20),
                    icon: Icons.close,
                    iconColor: Colors.redAccent
                  ),
                ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: searchBloc.products.empty,
            initialData: false,
            builder: (context, snapshot) {
              bool show = snapshot.data;
              return AnimatedOpacity(
                duration: duration,
                opacity: show? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/img/icSadFace.webp", width: 200, height: 200),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Constants.Colors.COLOR_PRIMARY.withOpacity(.8),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text(Strings.strings["empty_search"], style: TextStyles.subtitleWhite, textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          StreamBuilder<List<Product>>(
            stream: searchBloc.products.success,
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Wrap();
              var list = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.only(bottom: insetBottom(context)),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return CardProduct(
                    model: list[index],
                    onCardClick: (product) => ScreenTransitions.push(context, ProductDetailsScreen(
                      productId: product.id,
                    )),
                    onFavoriteButtonPressed: (favorite, active) {
                      if(active){
                        searchBloc.addToFavorite(favorite);
                        list[index].favorite = favorite;
                      } else {
                        searchBloc.removeFromFavorite(favorite);
                        list[index].favorite = null;
                      }
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}