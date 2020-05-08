import 'dart:developer' as dev;

import 'package:data/entity/Category.dart';
import 'package:data/entity/Favorite.dart';
import 'package:data/entity/Product.dart';
import 'package:data/repository/CategoryRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {

  BehaviorSubject<List<Product>> _highlights = BehaviorSubject();
  Observable<List<Product>> get highlights => _highlights.stream;

  BehaviorSubject<List<Category>> _categories = BehaviorSubject();
  Observable<List<Category>> get categories => _categories.stream;

  BehaviorSubject<List<Product>> _favorites = BehaviorSubject();
  Observable<List<Product>> get favorites => _favorites.stream;

  final ProductsRepository productsRepository = inject();
  final CategoryRepository categoryRepository = inject();
  final FavoritesRepository favoritesRepository = inject();

  void getFavorites() {
    launchData(() async {
      _favorites.add(await productsRepository.getFavorites());
    });
  }

  void getCategories() {
    launchData(() async {
      _categories.add(await categoryRepository.getCategories());
    });
  }

  void addToFavorite(Favorite favorite) {
    favoritesRepository.addToFavorites(favorite);
  }

  void removeFromFavorite(Favorite favorite) {
    favoritesRepository.removeFromFavorite(favorite);
  }

  void getHighlights() {
    launchData(() async {
      _highlights.add(await productsRepository.getHighlights());
    });
  }

  void refreshCategories() {
    categoryRepository.refreshCategories();
  }

  void refreshHighlights(){
    launchData(() async {
      await productsRepository.refreshProducts();
      _highlights.add(await productsRepository.getHighlights());
    });
  }

}