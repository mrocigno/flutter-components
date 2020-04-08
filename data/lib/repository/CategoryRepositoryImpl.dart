
import "dart:developer" as dev;
import 'package:domain/entity/Category.dart';
import "package:domain/repository/CategoryRepository.dart";

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryLocal local;
  final CategoryRemote remote;

  CategoryRepositoryImpl({
      this.local,
      this.remote
  });

  @override
  Future<List<Category>> getCategories(){
    return remote.getCategories();
  }

}

class CategoryLocal {

}

class CategoryRemote {

  Future<List<Category>> getCategories() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Category(
        id: 1,
        imgPath: "path",
        name: "Acessórios"
      ),
      Category(
        id: 1,
        imgPath: "path",
        name: "Motos"
      ),
      Category(
        id: 1,
        imgPath: "path",
        name: "Peças"
      ),
      Category(
        id: 1,
        imgPath: "path",
        name: "Capacetes"
      ),
      Category(
        id: 1,
        imgPath: "path",
        name: "Escapadores"
      ),
      Category(
        id: 1,
        imgPath: "path",
        name: "Corrente"
      ),
    ];
  }

}
