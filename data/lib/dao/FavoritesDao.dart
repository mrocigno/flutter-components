/*
* Created to flutter-components at 05/07/2020
*/
import "dart:developer" as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/Favorite.dart';
import 'package:data/mapper/FavoriteMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class FavoritesDao extends DaoBase<Favorite>{

  @override
  String get tableName => "favorites";

  @override
  String get identifier => "productId";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "productId INTEGER PRIMARY KEY, "
        "userId INTEGER"
      ")";

  @override
  FavoriteMapper get mapper => inject();



}