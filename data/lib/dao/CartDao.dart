import 'dart:developer' as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Cart.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

class CartDao extends DaoBase<Cart> {

  @override
  String get tableName => "cart";

  @override
  String get identifier => "productId";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "productId INTEGER PRIMARY KEY, "
        "amount INTEGER"
      ")";

  @override
  CartMapper get mapper => inject();

  Future<List<Map<String, dynamic>>> getProducts() async => await db.rawQuery(
      "SELECT pr.id, pr.value, ct.amount FROM $tableName as ct INNER JOIN products as pr ON pr.id = ct.productId"
    );

}