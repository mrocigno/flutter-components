
import "dart:developer" as dev;
import 'package:data/local/dao/CategoriesDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/Category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  final _Local _local = _Local();
  final _Remote _remote = _Remote();

  Future<List<Category>> getCategories(){
    return _local.getAllCategories();
  }

  Future<void> refreshCategories() async {
    List<Category> categories = await _remote.getCategories();
    categories?.forEach((element) {
      _local.addCategory(element);
    });
  }

}

class _Local {

  CategoriesDao _dao = Config.daoProvider();

  void addCategory(Category category){
    _dao.save(category, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Category>> getAllCategories(){
    return _dao.getList();
  }

}

class _Remote {

  Future<List<Category>> getCategories() async {
//    await Future.delayed(Duration(seconds: 2));
//
//    return [
//      {
//        "id": 1,
//        "imgPath": "path",
//        "name": "Acessórios"
//      },
//      {
//        "id": 2,
//        "imgPath": "path",
//        "name": "Motos"
//      },
//      {
//        "id": 3,
//        "imgPath": "path",
//        "name": "Peças"
//      }
//    ].map((e) => mapper.fromResponse(e)).toList();
  }

}
