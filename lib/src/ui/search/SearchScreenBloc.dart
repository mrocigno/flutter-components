/*
* Created to flutter-components at 05/11/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SearchScreenBloc extends BaseBloc {

  final ProductsRepository _productsRepository = inject();
  final FavoritesRepository _favoritesRepository = inject();

  BehaviorSubject<List<Product>> _products = BehaviorSubject();
  ValueStream<List<Product>> get products => _products.stream;

  void addToFavorite(Favorite favorite) {
    _favoritesRepository.addToFavorites(favorite);
  }

  void removeFromFavorite(Favorite favorite) {
    _favoritesRepository.removeFromFavorite(favorite);
  }

  void notifyDataChange() {
    _products.add(_products.value);
  }

  void performSearch(String search) {
    launchData(() async {
      await Future.delayed(Duration(seconds: 2));
      _products.add(await _productsRepository.search(search));
    });
  }

}