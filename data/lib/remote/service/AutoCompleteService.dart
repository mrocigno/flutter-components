/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Photo.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/mapper/SearchMapper.dart';
import 'package:data/remote/interceptor/UserInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class AutoCompleteService {
  
  Dio _dio = inject();
  SearchMapper _mapper = inject();

  Future<List<String>> autoComplete(String search) async {
    Response response = await _dio.get("autocomplete");

    if(response.data != null) {
      return (response.data as List).map((e) => _mapper.fromRemoteMap(e)).toList();
    }
    return null;
  }

}