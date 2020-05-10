import 'package:data/dao/CartDao.dart';
import 'package:data/dao/FavoritesDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class ProductsDao extends DaoBase<Product> {
  
  @override
  String get sqlCreate =>
    "CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "provider TEXT, "
          "name TEXT, "
          "description TEXT, "
          "mainImageUrl TEXT, "
          "value REAL, "
          "highlight INTEGER"
      ")";

  @override
  String get tableName => "products";
  
  @override
  ProductMapper get mapper => inject();

  // I know, this is a workaround, but flutter has no reflection
  FavoritesDao get favoritesDao => Config.daoProvider();
  CartDao get cartDao => Config.daoProvider();

  Future<List<Product>> getHighlights() async {
    var query = await db.query(tableName,
      where: "highlight = 1"
    );
    
    return _transformMap(query);
  }

  Future<List<Product>> getFavorites() async {
    var query = await db.rawQuery(
      "SELECT pd.* FROM $tableName as pd INNER JOIN ${favoritesDao.tableName} as fv ON pd.id = fv.productId"
    );

    return _transformMap(query);
  }

  Future<List<Product>> getInCart() async {
    var query = await db.rawQuery(
      "SELECT pd.* FROM $tableName as pd INNER JOIN ${cartDao.tableName} as ct ON pd.id = ct.productId"
    );

    return _transformMap(query);
  }

  Future<List<Product>> _transformMap(List<Map<String, dynamic>> map) async {
    List<Product> result = [];
    for(int i = 0; i < map.length; i++) {
      var product = mapper.fromDataMap(map[i]);
      product.favorite = await favoritesDao.getById(product.id);
      product.cart = await cartDao.getById(product.id);
      result.add(product);
    }
    return result;
  }

}