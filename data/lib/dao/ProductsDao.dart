import 'package:data/db/DaoBase.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:domain/entity/Product.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sql.dart';

class ProductsDao extends DaoBase {
  
  @override
  String get sqlCreate => 
    "CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "remoteId INTEGER UNIQUE, "
          "name TEXT, "
          "mainImageUrl TEXT, "
          "value REAL, "
          "favorite NUMERIC"
      ")";

  @override
  String get tableName => "products";
  
  @override
  ProductMapper get mapper => ProductMapper();

  void setFavorite(Product product){
    db.update(tableName, mapper.toMap(product), 
      where: "id == ?",
      whereArgs: [product.localId]
    );
  }

  void addProduct(Product product){
    db.insert(tableName, mapper.toMap(product), 
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<List<Product>> getHighlights() async {
    List<Product> result = (await db.query(tableName)).map((e) => mapper.fromMap(e)).toList();
    
    return result;
  }

  Future<List<Product>> getFavorites() async {
    List<Product> result = (await db.query(tableName, 
      where: "favorite = 1"
    )).map((e) => mapper.fromMap(e)).toList();
    
    return result;
  }

}