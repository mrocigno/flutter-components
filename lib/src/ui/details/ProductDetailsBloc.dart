import 'dart:developer' as dev;

import 'package:data/entity/Cart.dart';
import 'package:data/entity/Product.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:mopei_app/src/di/Injection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailsBloc extends BaseBloc {

  ProductsRepository productsRepository = Injection.inject();
  CartRepository cartRepository = Injection.inject();

  BehaviorSubject<Cart> _cart = BehaviorSubject();
  Observable<Cart> get cart => _cart.stream;

  BehaviorSubject<bool> _favorite = BehaviorSubject();
  Observable<bool> get favorite => _favorite.stream;

  void updateFavorite(Product product) {
    launchData(() async {
      productsRepository.setFavorite(product);
      _favorite.add(product.favorite);
    });
  }

  void getCartData(Product product){
    launchData(() async {
      _cart.add(await cartRepository.getCart(product.localId));
    });
  }

  void addToCart(Product product){
    launchData(() async {
      _cart.add(await cartRepository.addToCart(product, 1));
    });
  }

  void removeFromCart(Cart cart) {
    launchData(() async {
      cartRepository.removeFromCart(cart);
      _cart.add(null);
    });
  }

}