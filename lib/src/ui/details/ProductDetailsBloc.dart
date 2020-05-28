import 'dart:developer' as dev;

import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailsBloc extends BaseBloc {

  ProductsRepository productsRepository = inject();
  CartRepository cartRepository = inject();
  FavoritesRepository favoritesRepository = inject();

  BehaviorSubject<Cart> _cart = BehaviorSubject();
  ValueStream<Cart> get cart => _cart.stream;

  BehaviorSubject<bool> _favorite = BehaviorSubject();
  ValueStream<bool> get favorite => _favorite.stream;

  void addToFavorite(Favorite favorite) {
    launchData(() async {
      favoritesRepository.addToFavorites(favorite);
      _favorite.add(true);
    });
  }

  void removeFromFavorite(Favorite favorite) {
    launchData(() async {
      favoritesRepository.removeFromFavorite(favorite);
      _favorite.add(false);
    });
  }

  void getCartData(Product product){
    launchData(() async {
      _cart.add(await cartRepository.getCart(product.id));
    });
  }

  void addToCart(Product product){
    launchData(() async {
      _cart.add(await cartRepository.save(Cart(
        productId: product.id,
        amount: 1
      )));
    });
  }

  void removeFromCart(Cart cart) {
    launchData(() async {
      cartRepository.removeFromCart(cart);
      _cart.add(null);
    });
  }

}