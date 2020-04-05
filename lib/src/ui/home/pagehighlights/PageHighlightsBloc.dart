import 'package:data/repository/FavoriteRepositoryImpl.dart';
import 'package:domain/entity/Item.dart';
import 'package:domain/usecase/HighlightsUseCase.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class PageHighlightsBloc extends BaseBloc {

  HighlightsUseCase useCase = Injection.inject();

  BehaviorSubject<List<Item>> highlights = BehaviorSubject();

  PageHighlightsBloc(){
    highlights.onCancel = () => highlights.close();
  }

  void addToFavorite(Item item){
    useCase.insertFavorite(item);
  }

  void getHighlights() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 2));
      highlights.add([
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094414550HDR.JPG",
          value: 20.00,
          name: "Retrovisor"
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094426318.jpg",
          value: 19.99,
          name: "Retrovisor de lado"
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094443068.jpg",
          value: 200.99,
          name: "Retrovisor de lado"
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
        Item(
          mainImageUrl: "https://crestana.com.br/img/imagens_produto/20191016_132440_1____IMG20191016094509685.jpg",
          value: 10.00,
          name: "Retrovisor por baixo",
          favorite: true
        ),
      ]);
    });
  }

}