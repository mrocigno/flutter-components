
import "dart:developer" as dev;

import 'package:domain/entity/Product.dart';

abstract class ProductsRepository {

  Future<void> refreshProducts();
  
  Future<List<Product>> getHighlights();

  Future<List<Product>> getFavorites();

  void setFavorite(Product product);

}
