import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sql.dart';

class ProductsDao extends DaoBase<Product> {
  
  @override
  String get sqlCreate =>
    "CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "remoteId INTEGER UNIQUE, "
          "provider TEXT, "
          "name TEXT, "
          "description TEXT, "
          "mainImageUrl TEXT, "
          "value REAL, "
          "favorite NUMERIC"
      ")";

  @override
  String get tableName => "products";
  
  @override
  ProductMapper get mapper => ProductMapper();

  void setFavorite(Product product){
    db.update(tableName, mapper.toDataMap(product),
      where: "id == ?",
      whereArgs: [product.localId]
    );
  }

  Future<List<Product>> getHighlights() async {
    List<Product> result = (await db.query(tableName)).map((e) => mapper.fromDataMap(e)).toList();
    
    return result;
  }

  Future<List<Product>> getFavorites() async {
    List<Product> result = (await db.query(tableName, 
      where: "favorite = 1"
    )).map((e) => mapper.fromDataMap(e)).toList();
    
    return result;
  }

}