import 'dart:developer' as dev;

import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Cart.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:data/mapper/SearchMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:data/local/db/Mapper.dart';
import 'package:sqflite/sqflite.dart';

class SearchDao extends DaoBase<String> {

  @override
  String get tableName => "search";

  @override
  String get identifier => "string";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "string TEXT, "
        "UNIQUE (string COLLATE NOCASE)"
      ")";

  @override
  SearchMapper get mapper => inject();

  Future<List<String>> getHistorySearch(String search) async {
    var list = await db.query(tableName,
      where: "string like ?",
      whereArgs: ["%$search%"]
    );
    return list.map((e) => mapper.fromDataMap(e)).toList();
  }

}