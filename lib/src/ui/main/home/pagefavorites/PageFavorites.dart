import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/animations/AnimatedStar.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageFavorites extends TabChild {

  @override
  String get title => Strings.strings["home_page_3"];

  @override
  StatelessWidget get child => _PageFavorites();

}

class _PageFavorites extends StatelessWidget {

  final HomeBloc bloc = inject();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Product>>(
        stream: bloc.favorites,
        builder: (context, snapshot) {
          List<Product> list = snapshot.data;
          if(list == null || list.length <= 0) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedStar(autoStart: true),
                  Text(Strings.strings["not_favored"], style: TextStyles.titleBlack,)
                ],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, top: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Strings.strings["favorites_title"],
                      style: TextStyles.titleBlack,
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
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var model = snapshot.data[index];
                      return CardProduct(
                        hideWhenDisfavor: true,
                        model: model,
                        onFavoriteButtonPressed: (favorite, active) async {
                          bloc.removeFromFavorite(favorite);
                          model.favorite = null;
                          await Future.delayed(Duration(milliseconds: 500));
                          bloc.getFavorites();
                        },
                      ) ;
                    },
                  )
              )
            ],
          );
        },
      ),
    );
  }


}