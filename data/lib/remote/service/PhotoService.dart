/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Photo.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/PhotoMapper.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/remote/interceptor/UserInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class PhotoService {
  
  Dio _dio = inject();
  PhotoMapper _mapper = inject();

  Future<List<Photo>> getPhotos(int productId) async {
    Response response = await _dio.get("products/photos");

    if(response.data != null) {
      return (response.data as List).map((e) => _mapper.fromRemoteMap(e)).toList();
    }
    return null;
  }

}