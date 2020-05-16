import 'dart:developer' as dev;

import 'package:data/entity/Photo.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class PhotoMapper extends Mapper<Photo> {
  @override
  Photo fromDataMap(Map<String, Object> input) => Photo(
    path: input["path"],
    num: input["num"],
    productId: input["productId"]
  );

  @override
  Photo fromResponse(Map<String, Object> input) {
    throw UnimplementedError();
  }

  @override
  Map<String, Object> toDataMap(Photo input) => {
    "productId": input.productId,
    "num": input.num,
    "path": input.path
  };
}