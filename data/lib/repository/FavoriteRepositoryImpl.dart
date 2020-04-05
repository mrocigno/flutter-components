import 'dart:developer' as dev;

import 'package:data/dao/FavoriteDao.dart';
import 'package:data/db/Config.dart';
import 'package:domain/entity/Item.dart';
import 'package:domain/repository/FavoriteRepository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {

  final FavoriteLocal local;

  FavoriteRepositoryImpl(this.local);

  @override
  insertFavorite(Item item) {
    local.insertFavorite(item);
  }

  @override
  Future<List<Item>> getAll() {
    return local.getFavorites();
  }

}

class FavoriteRemote {

}

class FavoriteLocal {

  FavoriteDao dao = Config.daoProvider();

  Future<List<Item>> getFavorites() {
    return dao.getAll();
  }

  insertFavorite(Item item){
    dao.insertOne(item);
  }

}