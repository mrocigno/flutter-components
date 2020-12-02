import 'dart:developer' as dev;

import 'package:data/local/entity/Category.dart';
import 'package:data/local/db/Mapper.dart';

class CategoryMapper extends Mapper<Category> {

  @override
  Category fromRemoteMap(Map<String, Object> input) => Category(
      id: input["id"],
      name: input["name"],
      imgPath: input["imgPath"]
  );

  @override
  Category fromDataMap(Map<String, Object> input) => Category(
    id: input["id"],
    name: input["name"],
    imgPath: input["imgPath"]
  );

  @override
  Map<String, Object> toDataMap(Category input) => {
    "id": input.id,
    "name": input.name,
    "imgPath": input.imgPath
  };



}