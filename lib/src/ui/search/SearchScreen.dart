/*
* Created to flutter-components at 05/10/2020
*/
import 'dart:async';
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
import 'package:mopei_app/src/ui/search/CardHistorySearch.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';
import 'package:mopei_app/src/ui/search/SearchBloc.dart';
import 'package:infrastructure/flutter/constants/Colors.dart' as Constants;
import 'package:mopei_app/src/ui/search/data/AutoCompleteModel.dart';
import 'package:mopei_app/src/ui/search/data/StreamMergeModel.dart';
import 'package:rxdart/rxdart.dart';

class SearchScreen extends BaseScreen with RouteObserverMixin {

  @override
  String get name => "SearchScreen";

  SearchBloc searchBloc = bloc();
  String initialData;
  String search;

  SearchScreen({this.initialData = ""}) : search = initialData;

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
    return BackgroundSliver(
      onWillPop: () async {
        if (searchBloc.isTyping) {
          hideKeyboard(context);
          searchBloc.isTyping = false;
          return false;
        }
        return true;
      },
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
        loadObserver: Rx.combineLatest2(searchBloc.products.loading, searchBloc.autoComplete.loading, (a, b) {
          if (a || b) return true;
          return false;
        }),
        onPerformSearch: performSearch,
        onTextChanged: (text) {
          search = text;
          searchBloc.isTyping = true;
          searchBloc.handleAutoComplete(text);
        },
      ),
      child: StreamBuilder<StreamMergeModel>(
        stream: Rx.combineLatest4(searchBloc.products.empty, searchBloc.products.error, searchBloc.products.success, searchBloc.typing, (a, b, c, d) {
          return StreamMergeModel(
            empty: a,
            error: b,
            success: c,
            typing: d
          );
        }),
        initialData: StreamMergeModel(),
        builder: (context, snapshot) {
          StreamMergeModel merge = snapshot.data;
          if (merge.isSearching) return searchingWidget;
          if (merge.isError) return errorWidget;
          if (merge.isEmpty) return emptyWidget;
          if (merge.isSuccess) return successWidget(merge.success);
          return SliverToBoxAdapter();
        },
      )
    );
  }

  void performSearch(String search) {
    if(search != ""){
      searchBloc.isTyping = false;
      searchBloc.performSearch(search);
      hideKeyboard(context);
    }
  }

  Widget get searchingWidget {
    searchBloc.getHistory(search);
    return StreamBuilder<List<AutoCompleteModel>>(
      stream: searchBloc.autoComplete.success,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null || snapshot.data.length <= 0) return SliverToBoxAdapter();
        List<AutoCompleteModel> list = snapshot.data;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: (index + 1) == list.length? insetBottom(context) : 0),
                child: CardHistorySearch(
                  model: list[index],
                  onPressed: (selected) {
                    _searchHeaderKey.currentState.searchText = selected;
                    performSearch(selected);
                  },
                ),
              );
            },
            childCount: list.length
          ),
        );
      },
    );
  }

  Widget get errorWidget {
    return SliverFillRemaining(
      child: Center(
        child: EmptyState(
          title: "Houve um erro",
          titleStyle: TextStyle(color: Colors.redAccent, fontSize: 20),
          icon: Icons.close,
          iconColor: Colors.redAccent
        )
      ),
    );
  }

  Widget get emptyWidget {
    return SliverToBoxAdapter(
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
  }

  Widget successWidget(List<Product> list) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: (index + 1) == list.length? insetBottom(context) : 0),
            child: CardProduct(
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
            ),
          );
        },
        childCount: list.length,
      )
    );
  }
}