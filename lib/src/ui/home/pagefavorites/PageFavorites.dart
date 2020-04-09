import 'package:domain/entity/Product.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/home/HomeBloc.dart';

class PageFavorites extends TabChild {

  final BuildContext context;

  PageFavorites(this.context);

  HomeBloc bloc = Injection.inject();

  @override
  String get title => Strings.strings["home_page_3"];

  @override
  Widget get child {
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
          child: StreamBuilder<List<Product>>(
            stream: bloc.favorites,
            builder: (context, snapshot) {
              return ListView.builder(
                padding: EdgeInsets.only(left: 20),
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CardProduct(
                    hideWhenDisfavor: true,
                    model: snapshot.data[index],
                    onFavoriteButtonPressed: () {
                      bloc.addToFavorite(snapshot.data[index]);
                    },
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

}