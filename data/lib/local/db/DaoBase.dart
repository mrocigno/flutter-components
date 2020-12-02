import 'package:data/local/db/Mapper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class DaoBase<Entity> {

  String get tableName;

  String get sqlCreate;

  Mapper<Entity> get mapper;

  /// It may necessary override if the primary key column has no named "id"
  String get identifier => "id";
  
  Database db;

  Future<Entity> save(Entity entity, {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace}) async {
    if(entity != null) {
      var i = await db.insert(tableName, mapper.toDataMap(entity),
          conflictAlgorithm: conflictAlgorithm
      );
    }
    return entity;
  }

  Future<void> saveMany(List<Entity> list, {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace}) async {
    if(list != null){
      var batch = db.batch();
      list?.forEach((entity) {
        batch.insert(tableName, mapper.toDataMap(entity),
            conflictAlgorithm: conflictAlgorithm
        );
      });
      await batch.commit(noResult: true);
    }
  }

  Future<void> delete(Entity entity) async {
    var json = mapper.toDataMap(entity);
    await db.delete(tableName,
      where: "$identifier = ?",
      whereArgs: [json[identifier]]
    );
  }

  void deleteAll({String where, List<dynamic> whereArgs}) {
    db.delete(tableName,
      where: where,
      whereArgs: whereArgs
    );
  }

  Future<List<Entity>> getList({String where, List<dynamic> whereArgs}) async {
    var list = await db.query(tableName,
        where: where,
        whereArgs: whereArgs
    );

    return list.map((e) => mapper.fromDataMap(e)).toList();
  }

  Future<Entity> findById(int id) async {
    var list = await db.query(tableName,
        where: "$identifier = ?",
        whereArgs: [id]
    );
    if(list.length > 0) return mapper.fromDataMap(list[0]);
    return null;
  }

  Future<Entity> findOne({@required String where, List whereArgs}) async {
    var list = await db.query(tableName,
        where: where,
        whereArgs: whereArgs
    );
    if(list.length > 0) return mapper.fromDataMap(list[0]);
    return null;
  }

}