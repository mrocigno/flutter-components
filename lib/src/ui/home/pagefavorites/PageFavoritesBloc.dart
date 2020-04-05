import 'dart:developer' as dev;

import 'package:data/repository/FavoriteRepositoryImpl.dart';
import 'package:domain/entity/Item.dart';
import 'package:domain/usecase/FavoritesUseCase.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/subjects.dart';

class PageFavoritesBloc extends BaseBloc {

  FavoritesUseCase useCase = Injection.inject();

  PageFavoritesBloc() {
    favorites.onCancel = () => favorites.close();
  }

  BehaviorSubject<List<Item>> favorites = BehaviorSubject();

  void getFavorites() {
    launchData(() async {
      favorites.add(await useCase.getFavorites());
    });
  }


}