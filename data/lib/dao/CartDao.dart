import 'dart:developer' as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Cart.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

class CartDao extends DaoBase<Cart> {
  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "productId INTEGER UNIQUE, "
        "amount INTEGER"
      ")";

  @override
  String get tableName => "cart";

  @override
  CartMapper get mapper => CartMapper();

  Future<Cart> getByProductId(int id) async {
    List list = await db.query(tableName,
      where: "productId = ?",
      whereArgs: [id]
    );
    if(list.length > 0) return mapper.fromDataMap(list[0]);
    return null;
  }

  Future<Cart> addToCart(Product product, int amount) async {
    Cart cart = Cart(
      productId: product.localId,
      amount: amount
    );
    cart.id = await db.insert(tableName, mapper.toDataMap(cart),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return cart;
  }

  void removeFromCart(Cart cart) async {
    await db.delete(tableName,
      where: "id = ?",
      whereArgs: [cart.id]
    );
  }
}