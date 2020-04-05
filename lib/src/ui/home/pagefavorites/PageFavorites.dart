import 'package:domain/entity/Item.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:mopei_app/src/ui/cards/CardHighlight.dart';
import 'package:mopei_app/src/ui/home/pagefavorites/PageFavoritesBloc.dart';

class PageFavorites extends TabChild {

  PageFavoritesBloc bloc = PageFavoritesBloc();

  @override
  String get title => Strings.strings["home_page_3"];

  @override
  // TODO: implement child
  Widget get child {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getFavorites();
    });

    return SingleChildScrollView(
      child: Container(
        height: 360,
        width: double.maxFinite,
        child: StreamBuilder<List<Item>>(
          stream: bloc.favorites,
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
              itemCount: snapshot.data?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child: CardHighlight(model: snapshot.data[index])
                );
              },
            );
          },
        ),
      )
    );
  }

}