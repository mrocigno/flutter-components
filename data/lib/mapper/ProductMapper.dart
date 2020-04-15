import 'package:data/entity/Product.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class ProductMapper extends Mapper<Product> {

  @override
  Map<String, Object> toDataMap(Product input) => {
    "favorite": input.favorite? 1 : 0,
    "id": input.localId,
    "mainImageUrl": input.mainImageUrl,
    "name": input.name,
    "description": input.description,
    "provider": input.provider,
    "remoteId": input.remoteId,
    "value": input.value
  };

  @override
  Product fromDataMap(Map<String, Object> input) => Product(
    favorite: input["favorite"] == 1,
    localId: input["id"],
    mainImageUrl: input["mainImageUrl"],
    provider: input["provider"],
    name: input["name"],
    description: input["description"],
    remoteId: input["remoteId"],
    value: input["value"]
  );

  @override
  Product fromResponse(Map<String, Object> input) => Product(
    favorite: input["favorite"] == 1,
    mainImageUrl: input["mainImageUrl"],
    provider: input["provider"],
    name: input["name"],
    description: input["description"],
    remoteId: input["id"],
    value: input["value"]
  );

}