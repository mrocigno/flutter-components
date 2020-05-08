import 'dart:developer' as dev;

import 'package:data/entity/Category.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class CategoryMapper extends Mapper<Category> {

  @override
  Category fromDataMap(Map<String, Object> input) => Category(
    id: input["id"],
    name: input["name"],
    imgPath: input["imgPath"]
  );

  @override
  Category fromResponse(Map<String, Object> input) => Category(
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