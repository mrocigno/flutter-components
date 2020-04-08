import 'package:data/model/ProductResponse.dart';
import 'package:domain/entity/Product.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class ProductMapper extends Mapper<ProductResponse, Product> {

  @override
  Map<String, Object> toMap(Product input) => { 
    "favorite": input.favorite? 1 : 0,
    "id": input.localId,
    "mainImageUrl": input.mainImageUrl,
    "name": input.name,
    "remoteId": input.remoteId,
    "value": input.value
  };

  @override
  Product fromMap(Map<String, Object> input) => Product(
    favorite: input["favorite"] == 1,
    localId: input["id"],
    mainImageUrl: input["mainImageUrl"],
    name: input["name"],
    remoteId: input["remoteId"],
    value: input["value"]
  );

  @override
  ProductResponse reverse(Product input) => ProductResponse(
    favorite: input.favorite,
    mainImageUrl: input.mainImageUrl,
    name: input.name,
    id: input.remoteId,
    value: input.value
  );

  @override
  Product transform(ProductResponse input) => Product(
    favorite: input.favorite,
    mainImageUrl: input.mainImageUrl,
    name: input.name,
    remoteId: input.id,
    value: input.value
  );

}