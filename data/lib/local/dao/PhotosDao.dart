import 'dart:developer' as dev;

import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Photo.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class PhotosDao extends DaoBase<Photo> {

  @override
  String get tableName => "photo";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "productId INTEGER, "
        "num INTEGER, "
        "path TEXT, "
        "UNIQUE(productId, num)"
      ")";

  @override
  PhotoMapper get mapper => inject();

  Future<List<Photo>> listByProductId(int productId) => getList(
    where: "productId = ?",
    whereArgs: [productId]
  );

}