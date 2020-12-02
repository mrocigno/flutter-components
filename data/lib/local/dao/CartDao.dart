import 'dart:developer' as dev;

import 'package:data/local/db/Mapper.dart';
import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:data/mapper/CartMapper.dart';
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