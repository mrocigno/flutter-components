/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/remote/interceptor/UserInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_useful_things/di/Injection.dart';

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

  Future<List<Product>> search(String search) async {
    Response response = await _dio.post("products/search", data: {
      "search": search
    });

    if(response.data != null) {
      return (response.data as List).map((e) => _mapper.fromRemoteMap(e)).toList();
    }
    return null;
  }

}