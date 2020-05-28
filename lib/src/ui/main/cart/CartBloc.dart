import 'dart:developer' as dev;

import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BaseBloc {

  final CartRepository cartRepository = inject();
  final ProductsRepository productsRepository = inject();

  final BehaviorSubject<List<Product>> _products = BehaviorSubject();
  ValueStream<List<Product>> get products => _products.stream;
  final BehaviorSubject<double> _total = BehaviorSubject();
  ValueStream<double> get total => _total.stream;

  void getProducts() => launchData(() async {
    _products.add(await productsRepository.getInCart());
    calculateTotal();
  });

  void save(Cart cart) => launchData(() async {
    cartRepository.save(cart);
  });

  void calculateTotal() => launchData(() async {
    _total.add(await cartRepository.calculate());
  });

  void removeFromCart(Cart cart) => launchData(() async {
    cartRepository.removeFromCart(cart);
  });

}