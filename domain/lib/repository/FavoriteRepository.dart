import 'dart:developer' as dev;

import 'package:domain/entity/Item.dart';

abstract class FavoriteRepository {

  insertFavorite(Item item);

  Future<List<Item>> getAll();

}