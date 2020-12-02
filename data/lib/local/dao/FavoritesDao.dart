/*
* Created to flutter-components at 05/07/2020
*/
import "dart:developer" as dev;

import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/mapper/FavoriteMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';

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