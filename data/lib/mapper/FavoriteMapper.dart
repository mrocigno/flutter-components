/*
* Created to flutter-components at 05/07/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Favorite.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class FavoriteMapper extends Mapper<Favorite> {

  @override
  Favorite fromRemoteMap(Map<String, Object> input) => Favorite(
    productId: input["productId"],
    userId: input["userId"]
  );

  @override
  Favorite fromDataMap(Map<String, Object> input) => Favorite(
    productId: input["productId"],
    userId: input["userId"]
  );

  @override
  Map<String, Object> toDataMap(Favorite input) => {
    "productId": input.productId,
    "userId": input.userId
  };
}