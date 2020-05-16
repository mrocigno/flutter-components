import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/routing/ScreenTransitions.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/details/ProductDetails.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageHighlights extends TabChild {

  @override
  String get title => Strings.strings["home_page_1"];

  @override
  StatelessWidget get child => _PageHighlights();

}

class _PageHighlights extends StatelessWidget{

  final HomeBloc bloc = sharedBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40, top: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.strings["highlights_title"],
                style: TextStyles.subtitleBlack,
              ),
              StreamBuilder(
                  stream: bloc.isLoading,
                  builder: (context, snapshot) {
                    if(snapshot.data ?? false){
                      return Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2
                          )
                      );
                    } else {
                      return Container();
                    }
                  }
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: StreamBuilder<List<Product>>(
            stream: bloc.highlights,
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
                      onCardClick: (product) => ScreenTransitions.push(context, ProductDetails(
                        model: product,
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
        )
      ],
    );
  }

}