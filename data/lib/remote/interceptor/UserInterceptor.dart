/*
* Created to flutter-components at 05/28/2020
*/
import "dart:developer" as dev;

import 'package:data/local/dao/UserDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/User.dart';
import 'package:data/repository/UserRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

const String HEADER_VERIFIERS = "verifiers";
const String HEADER_USER_TOKEN = "user-token";

class UserInterceptor extends InterceptorsWrapper {

  final Dio dio;

  UserInterceptor(this.dio);
  UserRepository get userRepository => inject();

  Future<String> get _token async {
    User session = await userRepository.getSession();
    return session?.token;
  }

  DioError cancel(RequestOptions options) => DioError(
    request: options,
    type: DioErrorType.CANCEL
  );

  @override
  Future onRequest(RequestOptions options) async {
    if(options.extra.keys.contains(HEADER_VERIFIERS)) {
      List<String> verifiers = options.extra[HEADER_VERIFIERS];
      for(int i = 0; i < verifiers.length; i++){
        switch(verifiers[i]) {
          case HEADER_USER_TOKEN: {
            var token = await _token;
            if(token != null) options.headers.addAll({HEADER_USER_TOKEN: token});
            else return cancel(options);
            break;
          }
          default: throw Exception("Verifier not defined");
        }
      }
    }
    return super.onRequest(options);
  }

}