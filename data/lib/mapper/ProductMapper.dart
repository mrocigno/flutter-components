
import 'package:data/local/entity/Photo.dart';
import 'package:data/local/entity/Product.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class ProductMapper extends Mapper<Product> {

  @override
  Product fromRemoteMap(Map<String, dynamic> input) {
    int photoNum = 1;
    return Product(
      id: input["id"],
      name: input["name"],
      mainImageUrl: input["mainImageUrl"],
      description: input["description"],
      highlight: input["highlight"] == 1,
      provider: input["provider"],
      value: input["value"],
      photos: (input["photos"] as List)?.map((e) => Photo(
        productId: input["id"],
        num: photoNum++,
        path: e
      ))?.toList()
    );
  }

  @override
  Map<String, Object> toDataMap(Product input) => {
    "highlight": input.highlight? 1 : 0,
    "id": input.id,
    "mainImageUrl": input.mainImageUrl,
    "name": input.name,
    "description": input.description,
    "provider": input.provider,
    "value": input.value
  };

  @override
  Product fromDataMap(Map<String, Object> input) => Product(
    highlight: input["highlight"] == 1,
    id: input["id"],
    mainImageUrl: input["mainImageUrl"],
    provider: input["provider"],
    name: input["name"],
    description: input["description"],
    value: input["value"]
  );

//  @override
//  Product fromResponse(Map<String, Object> input) {
//    int photoNum = 1;
//    return Product(
//        highlight: input["highlight"] == 1,
//        mainImageUrl: input["mainImageUrl"],
//        provider: input["provider"],
//        name: input["name"],
//        description: input["description"],
//        id: input["id"],
//        value: input["value"],
//        photos: (input["photos"] as List)?.map((e) => Photo(
//            productId: input["id"],
//            num: photoNum++,
//            path: e
//        ))?.toList()
//    );
//  }

}