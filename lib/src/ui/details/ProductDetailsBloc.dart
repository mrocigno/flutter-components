import 'dart:developer' as dev;

import 'package:data/entity/Product.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailsBloc extends BaseBloc {

  ProductsRepository productsRepository = Injection.inject();

  BehaviorSubject<bool> _onCart = BehaviorSubject();
  Observable<bool> get onCart => _onCart.stream;

  BehaviorSubject<bool> _favorite = BehaviorSubject();
  Observable<bool> get favorite => _favorite.stream;

  void updateFavorite(Product product) {
    launchData(() async {
      productsRepository.setFavorite(product);
      _favorite.add(product.favorite);
    });
  }

  void updateCart(Product product){
    launchData(() async {
      bool value = _onCart.value ?? false;
      _onCart.add(!value);
    });
  }

}