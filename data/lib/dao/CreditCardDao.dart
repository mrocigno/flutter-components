import 'dart:developer' as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/CreditCard.dart';
import 'package:data/mapper/CreditCardMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:sqflite/sqflite.dart';

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
    await save(actualDefault..isDefault = false, conflictAlgorithm: ConflictAlgorithm.replace);
    await save(card..isDefault = true, conflictAlgorithm: ConflictAlgorithm.replace);
  }

}