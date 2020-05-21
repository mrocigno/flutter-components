import 'dart:developer' as dev;

import 'package:data/db/DaoBase.dart';
import 'package:data/entity/CreditCard.dart';
import 'package:data/mapper/CartMapper.dart';
import 'package:data/mapper/CreditCardMapper.dart';
import 'package:infrastructure/flutter/di/Injection.dart';

class CreditCardDao extends DaoBase<CreditCard> {

  @override
  String get tableName => "credit_card";

  @override
  String get sqlCreate => "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY, "
        "placeHolder TEXT, "
        "cardHolderName TEXT, "
        "entityFlag TEXT"
      ")";

  @override
  CreditCardMapper get mapper => inject();

}