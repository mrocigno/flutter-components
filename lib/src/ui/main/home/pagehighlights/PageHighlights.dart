import 'package:data/local/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/base/BaseFragment.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/carousel/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetailsScreen.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageHighlights extends TabChild {

  @override
  String get title => Strings.strings["home_page_1"];

  @override
  Widget get child => _PageHighlights();

}

class _PageHighlights extends StatefulWidget{

  @override
  _PageHighlightsState createState() => _PageHighlightsState();

}

class _PageHighlightsState extends BaseFragment<_PageHighlights> {

  HomeBloc bloc = sharedBloc();

  @override
  void initState() {
    super.initState();
    bloc.getHighlights();
  }

  @override
  void onComeback() {
    bloc.getHighlights();
  }

  @override
  Widget buildFragment(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<List<Product>>(
          stream: bloc.highlights.success,
          builder: (context, snapshot) {
            return RefreshIndicator(
              onRefresh: () async => bloc.refreshHighlights(),
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20),
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var model = snapshot.data[index];
                  return CardProduct(
                    model: model,
                    onCardClick: (product) => ScreenTransitions.push(context, ProductDetailsScreen(
                      productId: product.id,
                    )),
                    onFavoriteButtonPressed: (favorite, active) {
                      if(active){
                        bloc.addToFavorite(favorite);
                        model.favorite = favorite;
                      } else {
                        bloc.removeFromFavorite(favorite);
                        model.favorite = null;
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
        StreamBuilder<bool>(
          stream: bloc.highlights.loading,
          initialData: false,
          builder: (context, snapshot) {
            if(!snapshot.data) return Wrap();
            return IgnorePointer(
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                child: RefreshProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }

}