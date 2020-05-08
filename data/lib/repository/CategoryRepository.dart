
import "dart:developer" as dev;
import 'package:data/dao/CategoriesDao.dart';
import 'package:data/db/Config.dart';
import 'package:data/entity/Category.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class CategoryRepository {
  final CategoryLocal _local = inject();
  final CategoryRemote _remote = inject();

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

class CategoryLocal {

  CategoriesDao _dao = Config.daoProvider();

  void addCategory(Category category){
    _dao.save(category);
  }

  Future<List<Category>> getAllCategories(){
    return _dao.getAll();
  }

}

class CategoryRemote {

  Future<List<Category>> getCategories() async {
    await Future.delayed(Duration(seconds: 2));
    CategoryMapper mapper = CategoryMapper();
    return [
      {
        "id": 1,
        "imgPath": "path",
        "name": "Acessórios"
      },
      {
        "id": 2,
        "imgPath": "path",
        "name": "Motos"
      },
      {
        "id": 3,
        "imgPath": "path",
        "name": "Peças"
      }
    ].map((e) => mapper.fromResponse(e)).toList();
  }

}
