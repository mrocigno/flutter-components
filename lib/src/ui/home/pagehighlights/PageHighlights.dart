import 'dart:async';

import 'package:domain/entity/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/components/TabView.dart';
import 'package:infrastructure/flutter/components/TextStyles.dart';
import 'package:infrastructure/flutter/constants/Strings.dart';
import 'package:infrastructure/flutter/utils/AnimationsUtils.dart';
import 'package:mopei_app/src/ui/cards/CardHighlight.dart';
import 'package:mopei_app/src/ui/home/pagehighlights/PageHighlightsBloc.dart';

class PageHighlights extends TabChild {

  PageHighlightsBloc bloc = PageHighlightsBloc();

  @override
  String get title => Strings.strings["home_page_1"];

  @override
  Widget get child {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getHighlights();
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40, top: 20, right: 20),
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
            child: StreamBuilder<List<Item>>(
              stream: bloc.highlights,
              builder: (context, snapshot) {
                return ListView.builder(
                  padding: EdgeInsets.only(left: 10, top: 20),
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
            )
        )
      ],
    );
  }

}
