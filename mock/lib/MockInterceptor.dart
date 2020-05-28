/*
* Created to flutter-components at 05/27/2020
*/
import 'dart:convert';
import "dart:developer" as dev;

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends InterceptorsWrapper {

  final Dio dio;

  MockInterceptor(this.dio);

  @override
  Future onRequest(RequestOptions options) async {
    await Future.delayed(Duration(seconds: 2));
    String stringsJson = await rootBundle.loadString("packages/mock/assets/${options.path.replaceAll("/", "-")}.json");
    var response = json.decode(stringsJson);

    return dio.resolve(response);
  }

}