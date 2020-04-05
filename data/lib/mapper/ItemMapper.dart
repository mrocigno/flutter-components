
import 'package:data/model/ItemResponse.dart';
import 'package:domain/entity/Item.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class ItemMapper extends Mapper<ItemResponse, Item> {
  @override
  ItemResponse reverse(Item input) => ItemResponse(
    favorite: input.favorite,
    mainImageUrl: input.mainImageUrl,
    name: input.name,
    value: input.value,
    id: input.remoteId
  );

  @override
  Item transform(ItemResponse input) => Item(
    favorite: input.favorite,
    mainImageUrl: input.mainImageUrl,
    name: input.name,
    value: input.value,
    remoteId: input.id
  );

  @override
  Map<String, Object> toMap(Item input) => {
    "favorite": (input.favorite? 1 : 0),
    "mainImageUrl": input.mainImageUrl,
    "name": input.name,
    "value": input.value,
    "remoteId": input.remoteId
  };

  @override
  Item fromMap(Map<String, Object> input) => Item(
    remoteId: input["remoteId"],
    value: input["value"],
    name: input["name"],
    mainImageUrl: input["mainImageUrl"],
    favorite: input["favorite"] == 1
  );

}