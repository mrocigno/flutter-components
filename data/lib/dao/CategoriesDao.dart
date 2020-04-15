import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Category.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
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
  CategoryMapper get mapper => CategoryMapper();

}