
import "dart:developer" as dev;
import 'dart:math';
import 'package:data/local/dao/CreditCardDao.dart';
import 'package:data/local/db/Config.dart';
import 'package:data/local/entity/CreditCard.dart';
import 'package:infrastructure/flutter/di/Injection.dart';
import 'package:infrastructure/flutter/livedata/MutableResponseStream.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardRepository {

  final _Local _local = _Local();
  final _Remote _remote = _Remote();

  Future<List<CreditCard>> refreshCards() async {
    // This should be removed when the API arrives
    await Future.delayed(Duration(seconds: 1));
    return getCards();

//    var list = await _remote.getCards();
//    if(list.length > 0){
//      _local.saveAll(list);
//    }
//    return list;
  }

  Future<List<CreditCard>> getCards() => _local.getAll();

  Future<void> removeCard(CreditCard creditCard) => _local.remove(creditCard);

  Future<void> setDefault(CreditCard selectedCard) => _local.setDefault(selectedCard);

  Future<CreditCard> addCreditCard(CreditCard card) async {
    // This should be removed when the API arrives
    await Future.delayed(Duration(seconds: 2));
    return await _local.save(card..id = Random(1).nextInt(DateTime.now().second));
  }

  void deleteRemoved() {
    _local.deleteRemoved();
  }

}

class _Local {
  CreditCardDao _dao = Config.daoProvider();

  void saveAll(List<CreditCard> list) {
    _dao.deleteAll();
    _dao.saveMany(list);
  }

  Future<CreditCard> save(CreditCard card) => _dao.save(card);

  Future<void> remove(CreditCard creditCard) async => await _dao.save(creditCard, conflictAlgorithm: ConflictAlgorithm.replace);

  Future<void> setDefault(CreditCard creditCard) => _dao.setDefault(creditCard);

  Future<List<CreditCard>> getAll() => _dao.getList();

  void deleteRemoved() => _dao.deleteAll(where: "isRemoved = 1");

}

class _Remote {



  Future<List<CreditCard>> getCards() async {
//    await Future.delayed(Duration(seconds: 1));
////    throw ErrorResponse(message: "erro mesmo");
//    return [
//      {
//        "id": 1,
//        "cardHolderName": "Matheus Rocigno",
//        "entityFlag": "MASTER",
//        "placeHolder": "xxxx xxxx xxxx 1234",
//        "isDefault": 1
//      },
//      {
//        "id": 2,
//        "cardHolderName": "Matheus R medeiros",
//        "entityFlag": "VISA",
//        "placeHolder": "xxxx xxxx xxxx 4321"
//      },
//      {
//        "id": 3,
//        "cardHolderName": "Matheus R medeiros",
//        "entityFlag": "VISA",
//        "placeHolder": "xxxx xxxx xxxx 5678"
//      },
//    ].map((e) => mapper.fromResponse(e)).toList();
  }

}
