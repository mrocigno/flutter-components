
import "dart:developer" as dev;
import "package:data/dao/FavoritesDao.dart";
import "package:data/db/Config.dart";
import 'package:data/entity/Favorite.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
class FavoritesRepository {

    final FavoritesLocal _local = inject();
    final FavoritesRemote _remote = inject();

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

}

class FavoritesLocal {

    FavoritesDao dao = Config.daoProvider();

    void add(Favorite favorite) => dao.save(favorite);

    void remove(Favorite favorite) => dao.remove(favorite);

}

class FavoritesRemote {}
