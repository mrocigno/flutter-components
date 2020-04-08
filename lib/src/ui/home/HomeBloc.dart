import 'dart:developer' as dev;

import 'package:domain/entity/Category.dart';
import 'package:domain/entity/Product.dart';
import 'package:domain/usecase/HomeUseCase.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {

  BehaviorSubject<List<Product>> _highlights = BehaviorSubject();
  Observable<List<Product>> get highlights => _highlights.stream;

  BehaviorSubject<List<Category>> _categories = BehaviorSubject();
  Observable<List<Category>> get categories => _categories.stream;

  BehaviorSubject<List<Product>> _favorites = BehaviorSubject();
  Observable<List<Product>> get favorites => _favorites.stream;

  HomeUseCase useCase = Injection.inject();

  void getFavorites() {
    launchData(() async {
      _favorites.add(await useCase.getFavorites());
    });
  }

  void getCategories() {
    launchData(() async {
      _categories.add(await useCase.getCategories());
    });
  }

  void addToFavorite(Product product){
    useCase.setFavorite(product);
  }

  void getHighlights() {
    launchData(() async {
      _highlights.add(await useCase.getHighlights());
      await useCase.refreshProducts();
      _highlights.add(await useCase.getHighlights());
    });
  }

}