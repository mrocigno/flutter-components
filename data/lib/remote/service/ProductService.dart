/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:dio/dio.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class ProductService {
  
  Dio _dio = inject();
  ProductMapper _mapper = inject();

  Future<List<Product>> getHighlights() async {
    Response response = await _dio.get("products/highlights");

    if(response.data != null) {
      return (response.data as List).map((e) => _mapper.fromRemoteMap(e)).toList();
    }
    return null;
  }

}