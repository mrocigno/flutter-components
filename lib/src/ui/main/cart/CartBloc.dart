import 'dart:developer' as dev;

import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:flutter_useful_things/base/BaseBloc.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:flutter_useful_things/livedata/MutableResponseStream.dart';
import 'package:flutter_useful_things/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BaseBloc {

  final CartRepository cartRepository = inject();
  final ProductsRepository productsRepository = inject();

  final MutableResponseStream<List<Product>> _products = MutableResponseStream();
  ResponseStream<List<Product>> get products => _products.observable;

  final BehaviorSubject<double> _total = BehaviorSubject();
  ValueStream<double> get total => _total.stream;

  void getProducts() {
    _products.postLoad(() => productsRepository.getInCart());
    calculateTotal();
  }

  void save(Cart cart) async {
    cartRepository.save(cart);
  }

  void calculateTotal() async {
    _total.add(await cartRepository.calculate());
  }

  void removeFromCart(Cart cart) async {
    cartRepository.removeFromCart(cart);
  }

  @override
  void close() {
    super.close();
    _total.close();
    _products.close();
  }

}