/*
* Created to flutter-components at 05/10/2020
*/
import "dart:developer" as dev;
import 'dart:math';

import 'package:data/entity/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseScreen.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundSliver.dart';
import 'package:infrastructure/flutter/components/backgrounds/BackgroundThemes.dart';
import 'package:infrastructure/flutter/components/backgrounds/FlexibleSpaceSearchBar.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/routing/AppRoute.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';
import 'package:mopei_app/src/ui/search/SearchScreenBloc.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;

// ignore: must_be_immutable
class SearchScreen extends BaseScreen with RouteObserverMixin {

  final SearchScreenBloc bloc = inject();
  final String initialData;
  final GlobalKey<FlexibleSpaceSearchBarState> _searchHeaderKey = GlobalKey();

  SearchScreen({this.initialData = ""});

  @override
  void onCalled() {
    if(initialData != "") {
      bloc.performSearch(initialData);
    }
  }

  @override
  void onComeback() {
    bloc.notifyDataChange();
  }

  @override
  String get name => "SearchScreen";

  @override
  Widget build(BuildContext context) {
    Widget error = Container();
    Widget nothingSearched = Container(
      padding: const EdgeInsets.only(top: 100),
      child: Text("Colocar um histórico de pesquisa aqui", style: TextStyles.subtitleBlack, textAlign: TextAlign.center)
    );
    Widget emptyList = Container(
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
    );

    return BackgroundSliver(
      theme: BackgroundThemes.search,
      expandedHeight: 130,
      flexibleSpaceBar: FlexibleSpaceSearchBar(
        key: _searchHeaderKey,
        initialData: initialData,
        loadObserver: bloc.isLoading,
        onPerformSearch: (search) {
          if(search != ""){
            bloc.performSearch(search);
          }
        },
      ),
      child: StreamBuilder<List<Product>>(
        stream: bloc.products,
        builder: (context, snapshot) {
          if(snapshot.hasError) return error;
          if(!snapshot.hasData) return nothingSearched;
          if(snapshot.data.length == 0) return emptyList;
          var list = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.only(bottom: insetBottom(context)),
            itemCount: list.length,
            itemBuilder: (context, index) {
              dev.log("$index");
              return CardProduct(
                model: list[index],
                onCardClick: (product) => ScreenTransitions.push(context, ProductDetails(
                  model: product,
                )),
                onFavoriteButtonPressed: (favorite, active) {
                  if(active){
                    bloc.addToFavorite(favorite);
                    list[index].favorite = favorite;
                  } else {
                    bloc.removeFromFavorite(favorite);
                    list[index].favorite = null;
                  }
                },
              );
            },
          );
        },
      )
    );
  }

}