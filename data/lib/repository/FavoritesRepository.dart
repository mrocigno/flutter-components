
import "dart:developer" as dev;
import 'package:data/local/dao/FavoritesDao.dart';
import 'package:data/local/dao/UserDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/User.dart';
import 'package:data/remote/service/UserService.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesRepository {

  final _Local _local = _Local();
  final _Remote _remote = _Remote();

  Future<void> addToFavorites(int productId) async {
    await _local.add(productId);
//        if(user){
//            remote.add(favorite);
//        }
  }

  Future<void> removeFromFavorite(Favorite favorite) async {
    await _local.remove(favorite);
//        if(user){
//            remote.remove(favorite);
//        }
  }

  Future<List<Favorite>> refreshFavorites() async {
    List<Favorite> list = await _remote.getFavorites();
    await _local.addAll(list);
    return list;
  }

}

class _Local {

  FavoritesDao favoriteDao = Config.daoProvider();
  UserDao userDao = Config.daoProvider();

  Future<void> add(int productId) async {
    User session = await userDao.getSession();
    await favoriteDao.save(Favorite(
      productId: productId,
      userId: session?.id
    ));
  }

  Future<void> remove(Favorite favorite) => favoriteDao.delete(favorite);

  Future<void> addAll(List<Favorite> list) => favoriteDao.saveMany(list, conflictAlgorithm: ConflictAlgorithm.ignore);

}

class _Remote {

  UserService userService = inject();

  Future<List<Favorite>> getFavorites() => userService.getFavorites();

}
