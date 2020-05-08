import 'dart:developer' as dev;

import 'package:data/entity/Cart.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class CartMapper extends Mapper<Cart> {
  @override
  Cart fromDataMap(Map<String, Object> input) => Cart(
    amount: input["amount"],
    productId: input["productId"]
  );

  @override
  Cart fromResponse(Map<String, Object> input) {
    throw UnimplementedError();
  }

  @override
  Map<String, Object> toDataMap(Cart input) => {
    "productId": input.productId,
    "amount": input.amount
  };
}