import 'dart:developer' as dev;


import 'package:data/local/entity/Cart.dart';
import 'package:data/local/db/Mapper.dart';

class CartMapper extends Mapper<Cart> {

  @override
  Cart fromRemoteMap(Map<String, Object> input) {
    // TODO: implement fromRemoteMap
    throw UnimplementedError();
  }

  @override
  Cart fromDataMap(Map<String, Object> input) => Cart(
    amount: input["amount"],
    productId: input["productId"]
  );

  @override
  Map<String, Object> toDataMap(Cart input) => {
    "productId": input.productId,
    "amount": input.amount
  };

}