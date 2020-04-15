import 'package:flutter/material.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

abstract class DaoBase<Entity> {

  String get tableName;

  String get sqlCreate;

  Mapper<Entity> get mapper;
  
  Database db;

  void addOne(Entity entity){
    db.insert(tableName, mapper.toDataMap(entity),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<List<Entity>> getAll() async => (await db.query(tableName)).map((e) {
    return mapper.fromDataMap(e);
  }).toList();

  Future<Entity> getById(int id) async {
    var list = await db.query(tableName,
        where: "id = ?",
        whereArgs: [id]
    );
    if(list.length > 0) return mapper.fromDataMap(list[0]);
    return null;
  }

}