import 'package:data/entity/Product.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/textviews/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/Functions.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:mopei_app/src/ui/cards/CardProduct.dart';
import 'package:mopei_app/src/ui/main/home/HomeBloc.dart';

class PageHighlights extends TabChild {

  final BuildContext context;

  PageHighlights(this.context);

  HomeBloc bloc = Injection.inject();

  @override
  String get title => Strings.strings["home_page_1"];

  @override
  StatelessWidget get child {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, top: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.strings["highlights_title"],
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
              stream: bloc.highlights,
              builder: (context, snapshot) {
                return RefreshIndicator(
                  onRefresh: () async => bloc.refreshHighlights(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    itemCount: snapshot.data?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CardProduct(
                        model: snapshot.data[index],
                        onFavoriteButtonPressed: () {
                          bloc.addToFavorite(snapshot.data[index]);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}
