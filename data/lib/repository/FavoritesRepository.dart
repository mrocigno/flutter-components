
import "dart:developer" as dev;
import 'package:data/local/dao/FavoritesDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Favorite.dart';
import 'package:data/remote/service/UserService.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesRepository {

    final _Local _local = _Local();
    final _Remote _remote = _Remote();

    void addToFavorites(Favorite favorite) {
        _local.add(favorite);
//        if(user){
//            remote.add(favorite);
//        }
    }

    void removeFromFavorite(Favorite favorite) {
        _local.remove(favorite);
//        if(user){
//            remote.remove(favorite);
//        }
    }

    Future<void> refreshRemoteFavorites() async {
        List<Favorite> list = await _remote.getFavorites();
        await _local.addAll(list);
    }

}

class _Local {

    FavoritesDao dao = Config.daoProvider();

    void add(Favorite favorite) => dao.save(favorite);

    void remove(Favorite favorite) => dao.delete(favorite);

    Future<void> addAll(List<Favorite> list) => dao.saveMany(list, conflictAlgorithm: ConflictAlgorithm.ignore);

}

class _Remote {

    UserService userService = inject();

    Future<List<Favorite>> getFavorites() => userService.getFavorites();

}
