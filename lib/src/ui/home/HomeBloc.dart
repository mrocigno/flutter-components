import 'dart:developer' as dev;

import 'package:domain/entity/Category.dart';
import 'package:domain/entity/Item.dart';
import 'package:domain/usecase/HomeUseCase.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {

  BehaviorSubject<List<Item>> _highlights = BehaviorSubject();
  Observable<List<Item>> get highlights => _highlights.stream;

  BehaviorSubject<List<Category>> _categories = BehaviorSubject();
  Observable<List<Category>> get categories => _categories.stream;

  BehaviorSubject<List<Item>> _favorites = BehaviorSubject();
  Observable<List<Item>> get favorites => _favorites.stream;

  HomeUseCase useCase = HomeUseCase(favoriteRepository: Injection.inject());

  void getFavorites() {
    launchData(() async {
      _favorites.add(await useCase.getFavorites());
    });
  }

  void addToFavorite(Item item){
    useCase.insertFavorite(item);
  }

  void getHighlights() {
    launchData(() async {
      await Future.delayed(Duration(seconds: 2));
      _highlights.add([
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