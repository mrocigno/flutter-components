import 'dart:developer' as dev;

import 'package:data/entity/CreditCard.dart';
import 'package:infrastructure/flutter/utils/Mapper.dart';

class CreditCardMapper extends Mapper<CreditCard> {
  @override
  CreditCard fromDataMap(Map<String, Object> input) => CreditCard(
    id: input["id"],
    cardHolderName: input["cardHolderName"],
    entityFlag: input["entityFlag"],
    placeHolder: input["placeHolder"]
  );

  @override
  CreditCard fromResponse(Map<String, Object> input) => CreditCard(
    id: input["id"],
    cardHolderName: input["cardHolderName"],
    entityFlag: input["entityFlag"],
    placeHolder: input["placeHolder"]
  );

  @override
  Map<String, Object> toDataMap(CreditCard input) => {
    "id": input.id,
    "cardHolderName": input.cardHolderName,
    "entityFlag": input.entityFlag,
    "placeHolder": input.placeHolder
  };
}