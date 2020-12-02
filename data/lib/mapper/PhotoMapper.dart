import 'dart:developer' as dev;

import 'package:data/local/entity/Photo.dart';
import 'package:data/local/db/Mapper.dart';

class PhotoMapper extends Mapper<Photo> {

  @override
  Photo fromRemoteMap(Map<String, Object> input) => Photo(
      path: input["path"],
      num: input["num"],
      productId: input["productId"]
  );

  @override
  Photo fromDataMap(Map<String, Object> input) => Photo(
    path: input["path"],
    num: input["num"],
    productId: input["productId"]
  );

  @override
  Map<String, Object> toDataMap(Photo input) => {
    "productId": input.productId,
    "num": input.num,
    "path": input.path
  };
  
}