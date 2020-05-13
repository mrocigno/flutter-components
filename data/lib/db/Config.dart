import 'package:data/dao/CartDao.dart';
import 'package:data/dao/CategoriesDao.dart';
import 'package:data/dao/FavoritesDao.dart';
import 'package:data/dao/ProductsDao.dart';
import 'package:data/dao/UserDao.dart';
import 'package:data/db/DaoBase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as dev;

class Config {

  static List<DaoBase> _dao = [
    ProductsDao(),
    CategoriesDao(),
    CartDao(),
    FavoritesDao(),
    UserDao()
  ];

  static T daoProvider<T extends DaoBase>() {
    for(DaoBase dao in _dao){
      if(dao is T){
        return dao;
      }
    }
    throw Exception("Dao not found");
  }

  static Future<Database> open() async {
    return openDatabase(
      join(await getDatabasesPath(), 'mopei.db'),
      version: 1,
      onCreate: (db, version) {
        _dao.forEach((value) {
          db.execute(value.sqlCreate);
          dev.log(value.sqlCreate);
        });
      },
      onOpen: (db) {
        _dao.forEach((element) {
          element.db = db;
        });
      },
    );
  }



}