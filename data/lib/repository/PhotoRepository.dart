
import "dart:developer" as dev;
import 'package:data/dao/PhotosDao.dart';
import "package:data/db/Config.dart";
import 'package:data/entity/Photo.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class PhotoRepository {
  final PhotoLocal _local = inject();
  final PhotoRemote _remote = inject();


}

class PhotoLocal {
  PhotosDao _dao = Config.daoProvider();

}

class PhotoRemote {


}
