
import "dart:developer" as dev;
import 'package:data/local/dao/ProductsDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/remote/service/ProductService.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

class ProductsRepository {
  final _Local _local = _Local();
  final _Remote _remote = _Remote();

  Future<List<Product>> getHighlights() => _local.getHighlights();

  Future<List<Product>> getFavorites() => _local.getFavorites();

  Future<List<Product>> getInCart() => _local.getInCart();

  Future<List<Product>> search(String search) => _local.search(search);

  Future<Product> getById(int id) => _local.getById(id);

  Future<void> refreshProducts() async {
    List<Product> products = await _remote.getProducts();
    _local.saveAll(products);
  }
}

class _Local {
  ProductsDao dao = Config.daoProvider();

  void addProduct(Product product) => dao.save(product, conflictAlgorithm: ConflictAlgorithm.replace);

  void saveAll(List<Product> list) => dao.saveAll(list);

  Future<Product> getById(int id) => dao.findById(id);

  Future<List<Product>> getHighlights() => dao.getHighlights();

  Future<List<Product>> getFavorites() => dao.getFavorites();

  Future<List<Product>> getInCart() => dao.getInCart();

  Future<List<Product>> search(String search) => dao.search(search);
}

class _Remote {

  ProductService service = inject();

  Future<List<Product>> getProducts() {
    return service.getHighlights();
  }

}