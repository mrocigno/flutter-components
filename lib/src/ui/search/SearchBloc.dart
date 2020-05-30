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
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:infrastructure/flutter/utils/IterableUtils.dart';
import 'package:rxdart/subjects.dart';

class SearchBloc extends BaseBloc {

  final ProductsRepository _productsRepository = inject();
  final FavoritesRepository _favoritesRepository = inject();

  MutableResponseStream<List<Product>> _products = MutableResponseStream();
  ResponseStream<List<Product>> get products => _products.observable;

  void addToFavorite(Favorite favorite) {
    _favoritesRepository.addToFavorites(favorite.productId);
  }

  void removeFromFavorite(Favorite favorite) {
    _favoritesRepository.removeFromFavorite(favorite);
  }

  void notifyDataChange() async {
    List<Product> products = _products.getSyncValue();
    String ids = products.joinString((e) => e.id);
    _products.addData(await _productsRepository.listByIds(ids));
  }

  void performSearch(String search) {
    _products.postLoad(() async {
      return await _productsRepository.search(search);
    });
  }

  @override
  void close() {
    super.close();
    _products.close();
  }

}