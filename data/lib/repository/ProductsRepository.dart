
import "dart:developer" as dev;
import 'package:data/local/dao/ProductsDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/remote/service/ProductService.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/utils/IterableUtils.dart';

class ProductsRepository {
  ProductsDao dao = Config.daoProvider();
  ProductService service = inject();

  Future<List<Product>> getHighlights() => dao.getHighlights();

  Future<List<Product>> getFavorites() => dao.getFavorites();

  Future<List<Product>> getInCart() => dao.getInCart();

  Future<List<Product>> search(String search) async {
    var list = await service.search(search);
    await dao.saveAll(list);
    String ids = list.joinString((e) => e.id);
    return await listByIds(ids);
  }

  Future<Product> getById(int id) => dao.findById(id);

  Future<List<Product>> listByIds(String ids) => dao.listByIds(ids);

  Future<void> refreshProducts() async {
    List<Product> products = await service.getHighlights();
    dao.saveAll(products);
  }
}