/*
* Created to flutter-components at 05/28/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Category.dart';
import 'package:data/mapper/CategoryMapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class CategoryService {

  Dio _dio = inject();
  CategoryMapper mapper = inject();

  Future<List<Category>> getCategories() async {
    Response response = await _dio.get("categories");

    if(response.data != null){
      return (response.data as List).map((e) => mapper.fromRemoteMap(e)).toList();
    }

    return null;
  }

}