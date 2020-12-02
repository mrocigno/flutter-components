
import "dart:developer" as dev;
import 'package:data/local/dao/PhotosDao.dart';
import 'package:data/local/dao/ProductsDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Photo.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/remote/service/PhotoService.dart';
import 'package:data/remote/service/ProductService.dart';
import 'package:flutter_useful_things/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

class PhotoRepository {
  PhotosDao dao = Config.daoProvider();
  PhotoService service = inject();

  Future<List<Photo>> getPhotos(int productId) async {
    List<Photo> localList = await dao.listByProductId(productId);
    if(localList.length > 0) {
      _refresh(productId);
      return localList;
    }
    return _refresh(productId);
  }

  Future<List<Photo>> _refresh(int productId) async {
    List<Photo> list = await service.getPhotos(productId);
    dao.saveMany(list, conflictAlgorithm: ConflictAlgorithm.ignore);
    return list;
  }

}