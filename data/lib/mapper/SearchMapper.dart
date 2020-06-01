import 'dart:developer' as dev;


import 'package:data/local/entity/Cart.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class SearchMapper extends Mapper<String> {

  @override
  String fromRemoteMap(Map<String, Object> input) => input["string"];

  @override
  String fromDataMap(Map<String, Object> input) => input["string"];

  @override
  Map<String, Object> toDataMap(String input) => {
    "string": input
  };

}