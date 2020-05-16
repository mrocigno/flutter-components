import 'dart:developer' as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Cart.dart';
import 'package:data/entity/Photo.dart';
import 'package:data/entity/Product.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';
import 'package:sqflite/sqflite.dart';

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