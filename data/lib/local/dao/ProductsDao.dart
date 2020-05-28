
import 'package:data/local/db/Config.dart';
import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

import 'CartDao.dart';
import 'FavoritesDao.dart';
import 'PhotosDao.dart';

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
  PhotosDao get photoDao => Config.daoProvider();
  CartDao get cartDao => Config.daoProvider();

  void saveAll(List<Product> list) {
    this.saveMany(list, conflictAlgorithm: ConflictAlgorithm.replace);
    list.forEach((product) {
      photoDao.saveMany(product.photos, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

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

  Future<List<Product>> search(String search) async {
    var query = await db.rawQuery(
      "SELECT pd.* FROM $tableName as pd WHERE name like ?",
      ["%$search%"]
    );

    return _transformMap(query);
  }

  Future<List<Product>> _transformMap(List<Map<String, dynamic>> map) async {
    List<Product> result = [];
    for(int i = 0; i < map.length; i++) {
      var product = mapper.fromDataMap(map[i]);
      product.favorite = await favoritesDao.findById(product.id);
      product.cart = await cartDao.findById(product.id);
      product.photos = await photoDao.getList(where: "productId = ?", whereArgs: [product.id]);
      result.add(product);
    }
    return result;
  }

}