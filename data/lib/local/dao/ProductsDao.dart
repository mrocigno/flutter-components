
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
//  PhotosDao get photoDao => Config.daoProvider();
  CartDao get cartDao => Config.daoProvider();

  Future<void> saveAll(List<Product> list) async {
    await saveMany(list, conflictAlgorithm: ConflictAlgorithm.replace);
//    for(int i = 0; i < list?.length ?? 0; i++){
//      await photoDao.saveMany(list[i].photos, conflictAlgorithm: ConflictAlgorithm.replace);
//    }
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

  Future<List<Product>> listByIds(String ids) async {
    var query = await db.query(tableName,
      where: "id in ($ids)"
    );

    return _transformMap(query);
  }

  @override
  Future<Product> findById(int id) async {
    var listMap = await db.query(tableName,
      where: "$identifier = ?",
      whereArgs: [id]
    );

    if(listMap.length > 0){
      var list = await _transformMap(listMap);
      return list[0];
    }
    return null;
  }

  Future<List<Product>> _transformMap(List<Map<String, dynamic>> map) async {
    List<Product> result = [];
    for(int i = 0; i < map.length; i++) {
      var product = mapper.fromDataMap(map[i]);
      product.favorite = await favoritesDao.findById(product.id);
      product.cart = await cartDao.findById(product.id);
      result.add(product);
    }
    return result;
  }

}