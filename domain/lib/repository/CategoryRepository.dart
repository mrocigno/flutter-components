
import "dart:developer" as dev;

import 'package:domain/entity/Category.dart';

abstract class CategoryRepository {

  Future<List<Category>> getCategories();

}
