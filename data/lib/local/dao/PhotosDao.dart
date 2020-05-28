import 'dart:developer' as dev;

import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Photo.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

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

}