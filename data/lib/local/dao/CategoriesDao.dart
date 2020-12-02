
import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Category.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:data/local/db/Mapper.dart';
import 'package:sqflite/sql.dart';

class CategoriesDao extends DaoBase<Category> {
  
  @override
  String get sqlCreate => 
    "CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "remoteId INTEGER UNIQUE, "
          "name TEXT, "
          "imgPath TEXT"
      ")";

  @override
  String get tableName => "categories";
  
  @override
  CategoryMapper get mapper => inject();

}