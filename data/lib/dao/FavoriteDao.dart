
import 'package:data/db/DaoBase.dart';
import 'package:data/mapper/ItemMapper.dart';
import 'package:domain/entity/Item.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao extends DaoBase {

  @override
  String get tableName => "favorites";

  @override
  String get sqlCreate =>
      "CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "remoteId INTEGER, "
          "name TEXT, "
          "mainImageUrl TEXT, "
          "value REAL, "
          "favorite NUMERIC"
      ")";

  @override
  ItemMapper get mapper => ItemMapper();

  Future<Item> insertOne(Item item) async {
    item.id = await db.insert(
        tableName,
        mapper.toMap(item),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    return item;
  }

  Future<List<Item>> getAll() async {
    List<Map<String, Object>> result = await db.query(tableName);
    return result.map((e) => mapper.fromMap(e)).toList();
  }

}