import 'dart:developer' as dev;

import 'package:domain/entity/Category.dart';
import 'package:domain/entity/Product.dart';
import 'package:domain/repository/CategoryRepository.dart';
import 'package:domain/repository/ProductsRepository.dart';

class HomeUseCase {

  final ProductsRepository productsRepository;
  final CategoryRepository categoryRepository;

  HomeUseCase({
    this.productsRepository,
    this.categoryRepository
  });

  Future<void> refreshProducts() {
    return productsRepository.refreshProducts();
  }

  Future<List<Product>> getHighlights(){
    return productsRepository.getHighlights();
  }

  Future<List<Category>> getCategories(){
    return categoryRepository.getCategories();
  }

  Future<List<Product>> getFavorites() {
    return productsRepository.getFavorites();
  }

  void setFavorite(Product product) async {
    productsRepository.setFavorite(product);
  }

}