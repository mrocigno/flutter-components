/*
* Created to flutter-components at 05/27/2020
*/
import "dart:developer" as dev;

import 'package:data/local/entity/Favorite.dart';
import 'package:data/local/entity/Product.dart';
import 'package:data/mapper/FavoriteMapper.dart';
import 'package:data/mapper/ProductMapper.dart';
import 'package:data/remote/interceptor/UserInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class UserService {
  
  Dio _dio = inject();
  FavoriteMapper _mapper = inject();

  Future<List<Favorite>> getFavorites() async {
    Response response = await _dio.get("products/favorites", options: Options(
      extra: {
        HEADER_VERIFIERS: [
          HEADER_USER_TOKEN
        ]
      }
    ));

    if(response.data != null) {
      return (response.data as List).map((e) => _mapper.fromRemoteMap(e)).toList();
    }
    return null;
  }

}