import 'dart:developer' as dev;

import 'package:data/local/db/DaoBase.dart';
import 'package:data/local/entity/CreditCard.dart';
import 'package:data/mapper/CreditCardMapper.dart';
import 'package:flutter_useful_things/di/Injection.dart';

class CreditCardDao extends DaoBase<CreditCard> {

  @override
  String get tableName => "credit_card";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY, "
        "placeHolder TEXT, "
        "cardHolderName TEXT, "
        "entityFlag TEXT, "
        "isDefault INTEGER, "
        "isRemoved INTEGER"
      ")";

  @override
  CreditCardMapper get mapper => inject();

  Future<void> setDefault(CreditCard card) async {
    var actualDefault = await findOne(where: "isDefault = 1");
    if(actualDefault != null) await save(actualDefault..isDefault = false);
    await save(card..isDefault = true);
  }

}