import 'dart:developer' as dev;

import 'package:data/local/entity/Category.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/CategoryRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {

  MutableResponseStream<List<Product>> _highlights = MutableResponseStream();
  ResponseStream<List<Product>> get highlights => _highlights.observable;

  BehaviorSubject<List<Category>> _categories = BehaviorSubject();
  ValueStream<List<Category>> get categories => _categories.stream;

  BehaviorSubject<List<Product>> _favorites = BehaviorSubject();
  ValueStream<List<Product>> get favorites => _favorites.stream;

  final ProductsRepository productsRepository = inject();
  final CategoryRepository categoryRepository = inject();
  final FavoritesRepository favoritesRepository = inject();

  void getFavorites() async {
    _favorites.add(await productsRepository.getFavorites());
  }

  void getCategories() async {
    _categories.add(await categoryRepository.getCategories());
  }

  void addToFavorite(Favorite favorite) {
    favoritesRepository.addToFavorites(favorite);
  }

  void removeFromFavorite(Favorite favorite) {
    favoritesRepository.removeFromFavorite(favorite);
  }

  void getHighlights() {
    _highlights.postLoad(() => productsRepository.getHighlights());
  }

  void refreshCategories() {
    categoryRepository.refreshCategories();
  }

  void refreshHighlights(){
    _highlights.postLoad(() async {
      await productsRepository.refreshProducts();
      return await productsRepository.getHighlights();
    });
  }

}