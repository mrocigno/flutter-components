import 'dart:developer' as dev;

import 'package:data/local/entity/Cart.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Photo.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/local/entity/User.dart';
import 'package:data/repository/CartRepository.dart';
import 'package:data/repository/FavoritesRepository.dart';
import 'package:data/repository/PhotoRepository.dart';
import 'package:data/repository/ProductsRepository.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:infrastructure/flutter/base/BaseBloc.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:infrastructure/flutter/livedata/ResponseStream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailsBloc extends BaseBloc {

  ProductsRepository productsRepository = inject();
  CartRepository cartRepository = inject();
  FavoritesRepository favoritesRepository = inject();
  PhotoRepository photoRepository = inject();
  UserRepository userRepository = inject();

  MutableResponseStream<Product> _product = MutableResponseStream();
  ResponseStream<Product> get product => _product.observable;

  MutableResponseStream<List<Photo>> _photos = MutableResponseStream();
  ResponseStream<List<Photo>> get photos => _photos.observable;

  void getProduct(int productId) {
    _product.postLoad(() => productsRepository.getById(productId),
      onSuccess: (data) {
        _photos.postLoad(() => photoRepository.getPhotos(productId));
      },
    );
  }

  void addToFavorite() async {
    int productId = _product.getSyncValue().id;
    await favoritesRepository.addToFavorites(productId);
    _product.postLoad(() => productsRepository.getById(productId));
  }

  void removeFromFavorite() async {
    Product product = _product.getSyncValue();
    await favoritesRepository.removeFromFavorite(product.favorite);
    _product.postLoad(() => productsRepository.getById(product.id));
  }

  void addToCart() async {
    int productId = _product.getSyncValue().id;
    await cartRepository.addToCart(productId);
    _product.postLoad(() => productsRepository.getById(productId));
  }

  void removeFromCart() async {
    Product product = _product.getSyncValue();
    await cartRepository.removeFromCart(product.cart);
    _product.postLoad(() => productsRepository.getById(product.id));
  }

  @override
  void close() {
    super.close();
    _product.close();
    _photos.close();
  }

}