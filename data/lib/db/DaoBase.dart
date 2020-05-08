import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

abstract class DaoBase<Entity> {

  String get tableName;

  String get sqlCreate;

  Mapper<Entity> get mapper;

  /// It may necessary override if the primary key column has no named "id"
  String get identifier => "id";
  
  Database db;

  Future<Entity> save(Entity entity, {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.ignore}) async {
    var i = await db.insert(tableName, mapper.toDataMap(entity),
        conflictAlgorithm: conflictAlgorithm
    );
    return entity;
  }

  Future<void> saveMany(List<Entity> list, {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.ignore}) async {
    var batch = db.batch();
    list.forEach((entity) {
      batch.insert(tableName, mapper.toDataMap(entity),
          conflictAlgorithm: conflictAlgorithm
      );
    });
    await batch.commit(noResult: true);
  }

  void remove(Entity entity) {
    var json = mapper.toDataMap(entity);
    db.delete(tableName,
      where: "$identifier = ?",
      whereArgs: [json[identifier]]
    );
  }

  Future<List<Entity>> getAll() async => (await db.query(tableName)).map((e) {
    return mapper.fromDataMap(e);
  }).toList();

  Future<Entity> getById(int id) async {
    var list = await db.query(tableName,
        where: "$identifier = ?",
        whereArgs: [id]
    );
    if(list.length > 0) return mapper.fromDataMap(list[0]);
    return null;
  }

}